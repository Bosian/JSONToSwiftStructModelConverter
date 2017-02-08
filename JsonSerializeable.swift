//
//  JsonSerializeable.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol JsonSerializeable {
    
    func toDictionary() -> JsonDictionary
    func toJsonData(_ options: JSONSerialization.WritingOptions) -> Data?
    func toJsonString(_ options: JSONSerialization.WritingOptions) -> String
}

extension JsonSerializeable
{
    public func toDictionary() -> JsonDictionary
    {
        var dictionary = Dictionary<String, Any>()
        let mirror = Mirror(reflecting: self)
        
        for (label, value) in mirror.children {
            
            guard let key = label else {
                continue
            }
            
            guard let value = Utilities.unwrap(value) else {
                continue
            }
            
            switch value
            {
            case _ as String,
                 _ as Bool,
                 _ as Int,
                 _ as Double,
                 _ as CGFloat:
                dictionary[key] = value
                
            case let array as ArrayType:
                dictionary[key] = array.toJsonArray()
                
            case let jsonSerializeable as JsonSerializeable:
                dictionary[key] = jsonSerializeable.toDictionary()
                
            default:
                break
            }
            
        }
        
        return dictionary
    }
    
    public func toJsonData(_ options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> Data?
    {
        let dictionary = toDictionary()
        
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: options)
        return data
    }
    
    public func toJsonString(_ options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> String
    {
        guard let data = toJsonData(options) else {
            return "{}"
        }
        
        return String(data: data, encoding: String.Encoding.utf8) ?? "{}"
    }
}
