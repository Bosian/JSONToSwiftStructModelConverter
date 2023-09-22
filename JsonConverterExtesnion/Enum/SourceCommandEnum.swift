//
//  SourceCommandEnum.swift
//  JsonConverterExtesnion
//
//  Created by 劉柏賢 on 2023/9/22.
//  Copyright © 2023 劉柏賢. All rights reserved.
//

import Foundation
import XcodeKit

enum SourceCommandType: String {
    case jsonDeserialization
    case decodable
    case postmanParameter

    init?(invocation: XCSourceEditorCommandInvocation) {

        guard let bundleID: String = Bundle.main.bundleIdentifier else {
            return nil
        }
        
        let sourceID: String = invocation.commandIdentifier.replacingOccurrences(of: "\(bundleID).", with: "")
        guard let type = SourceCommandType(rawValue: sourceID) else {
            return nil
        }

        self = type
    }
}
