//
//  MirrorExtension.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/1/17.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

public struct Utilities
{
    public static func unwrap(_ subject: Any) -> Any? {
        
        var value: Any?
        let mirrored = Mirror(reflecting:subject)
        
        if mirrored.displayStyle != .optional {
            value = subject
        } else if let firstChild = mirrored.children.first {
            value = firstChild.value
        }
        
        return value
    }
}
