//
//  SourceEditorCommand.swift
//  JsonConverterExtesnion
//
//  Created by 劉柏賢 on 2018/1/14.
//  Copyright © 2018年 劉柏賢. All rights reserved.
//

import Foundation
import XcodeKit
import AppKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        defer {
            // Signal to Xcode that the command has completed.
            completionHandler(nil)
        }
        
        let paste = NSPasteboard.general
        guard let json: String = paste.string(forType: NSPasteboard.PasteboardType.string) else {
            return
        }
        
        print(json)

        guard let type = SourceCommandType(invocation: invocation) else {
            return
        }
        
        let jsonModel: String = {
            switch type {
                case .jsonDeserialization:
                    return json.jsonModel
                    
                case .decodable:
                    return json.jsonDecodableModel

                case .postmanParameter:
                    return json.jsonFromPostmanParams

                case .generateUnitTest:
                    return json.generateUnitTest
            }
        }()

        print(jsonModel)
        
        guard !jsonModel.isEmpty else {
            return
        }
        
        let lines = invocation.buffer.lines
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
            return
        }

        let lineNumber: Int = selection.start.line + 1
        let adjustLineNumber: Int =  0...lines.count ~= lineNumber ? lineNumber : lines.count

        lines.insert(jsonModel, at: adjustLineNumber)
    }
}
