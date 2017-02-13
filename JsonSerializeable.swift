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
        
        let converter = self as? PropertyConverters
        var propertyConverters = converter?.propertyConverters() ?? []
        
        let propertyMapper = self as? PropertyMapping
        var propertyMappings = propertyMapper?.propertyMapping() ?? []
        
        for (label, value) in mirror.children {
            
            guard let propertyName = label else {
                continue
            }
            
            guard let value = Utilities.unwrap(value) else {
                continue
            }
            
            // PropertyMapping, PropertyConverter
            let outputKey = getOutputKey(propertyName, propertyMappings: &propertyMappings)
            guard let outputValue = getOutputValue(propertyName, value: value, converters: &propertyConverters) else {
                continue
            }
            
            switch outputValue
            {
            case _ as String,
                 _ as Bool,
                 _ as Int,
                 _ as Double,
                 _ as CGFloat:
                dictionary[outputKey] = outputValue
                
            case let array as ArrayType:
                dictionary[outputKey] = array.toJsonArray()
                
            case let jsonSerializeable as JsonSerializeable:
                dictionary[outputKey] = jsonSerializeable.toDictionary()
                
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
    
    /**
     取得QueryString的 Key
     
     - parameter propertyName:     屬性名稱
     - parameter propertyMappings: propertyMappings description
     
     - returns: 轉換後的Key
     */
    private func getOutputKey(_ propertyName: String, propertyMappings: inout [(String?, String?)]) -> String
    {
        var outputKey: String = propertyName
        
        // 尋找該屬性是否有使用 propertyMapping
        let propertyMappingIndexWrapped = propertyMappings.index(where: { (parameter: (String?, String?)) -> Bool in
            return parameter.0 == propertyName
        })
        
        guard let propertyMappingIndex = propertyMappingIndexWrapped else
        {
            return propertyName
        }
        
        outputKey = propertyMappings[propertyMappingIndex].1 ?? propertyName
        propertyMappings.remove(at: propertyMappingIndex)
        
        return outputKey
    }
    
    /**
     取得QueryString的Value
     
     - parameter propertyName: 屬性名稱
     - parameter value:        屬性值
     - parameter converters:   converters description
     
     - returns: 轉換後的Value
     */
    private func getOutputValue(_ propertyName: String, value: Any, converters: inout [(String?, (Any?) -> (), () -> Any?)]) -> Any?
    {
        // 尋找該屬性是否有使用 propertyConverter
        let indexWrapped = converters.index(where: { (parameter: (String?, (Any?) -> (), () -> Any?)) -> Bool in
            return propertyName == parameter.0
        })
        
        // 該屬性是使用 propertyConverter
        guard let index = indexWrapped else
        {
            return value
        }
        
        let converter = converters[index]
        
        // 移除已Match的
        converters.remove(at: index)
        
        // 回傳轉換後的Value
        return converter.2()
    }
}
