//
//  SourceEditorCommand.swift
//  JsonConvereterExtesnion
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
        
        let jsonModel: String = json.jsonModel
        print(jsonModel)
        
        guard !jsonModel.isEmpty else {
            return
        }
        
        let lines = invocation.buffer.lines
//        // Reverse the order of the lines in a copy.
//        let updatedText = Array(lines.reversed())
//        lines.removeAllObjects()
        lines.addObjects(from: [jsonModel])
    }
}
