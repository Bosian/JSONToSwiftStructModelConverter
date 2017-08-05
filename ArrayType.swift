//
//  Viewer.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol ArrayType
{
    var arrayGenericType: Any { get }
    func getJsonSerializableArray() -> [JsonSerializeable]?
    
    func toJsonArray() -> Array<Any>
    func toJsonData(_ options: JSONSerialization.WritingOptions) -> Data?
    func toJsonString(_ options: JSONSerialization.WritingOptions) -> String
}

extension Array where Element: JsonDeserializeable
{
    public init(jsonArray: JsonArray)
    {
        self.init()
        
        #if DEBUG
            print("\r\n\r\nJson反序列化(jsonArray): \r\n\(jsonArray)\r\n")
            
            for (index, jsonDictionary) in jsonArray.enumerated()
            {
                print("\r\njsonArray index: \(index) 下方")
                self.append(Element(jsonDictionary: jsonDictionary))
            }
            
            print("\r\njsonArray end\r\n\r\n")
        
        #else
            for jsonDictionary in jsonArray
            {
                self.append(Element(jsonDictionary: jsonDictionary))
            }
        #endif
    }
}

extension Array: ArrayType 
{
    public var arrayGenericType: Any {
        return Element.self
    }
    
    public func getJsonSerializableArray() -> [JsonSerializeable]? {
        
        var array: [JsonSerializeable] = []
        
        for item in self {
            
            switch item {
            case _ as String,
                 _ as Bool,
                 _ as Int,
                 _ as Double,
                 _ as CGFloat:
                
                return nil
                
            case let item as JsonSerializeable:
                array.append(item)
                
            default:
                return nil
            }
        }
        
        return array
    }

    public func toJsonArray() -> Array<Any>
    {
        guard let array = self.getJsonSerializableArray() else
        {
            return self
        }
        
        var jsonArray: Array<Any> = []
        for jsonSerializeable in array {
            jsonArray.append(jsonSerializeable.toDictionary())
        }
        
        return jsonArray
    }
    
    public func toJsonData(_ options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> Data?
    {
        let jsonArray = toJsonArray()
        
        let data = try? JSONSerialization.data(withJSONObject: jsonArray, options: options)
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
