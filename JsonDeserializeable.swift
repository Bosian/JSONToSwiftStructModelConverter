//
//  JsonDeserializeable.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol JsonDeserializeable {
    init(jsonDictionary: JsonDictionary)
    init(jsonString: String?)
    
    // 以下需struct各自實作
    init()
    mutating func jsonMapping(_ jsonDictionary: JsonDictionary)
}

extension JsonDeserializeable
{
    public init(jsonDictionary: JsonDictionary)
    {
        #if DEBUG
            print("\r\nJson反序列化(jsonDictionary): \r\n\(jsonDictionary)")
        #endif
    
        self.init()
    
        jsonMapping(jsonDictionary)
        
        #if DEBUG
            print("\r\nJson反序列化(result): \r\n\(self)")
        #endif
    }
    
    public init(jsonString: String?)
    {
        self.init()
        
        guard let data = jsonString?.data(using: String.Encoding.utf8) else {
            return
        }
        
        do
        {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

            switch jsonObject {
            case let jsonDictionary as JsonDictionary:
                #if DEBUG
                    print("\r\n\r\nJson反序列化(jsonString): \r\n\(jsonDictionary)")
                #endif
                
                jsonMapping(jsonDictionary)
                
                #if DEBUG
                    print("\r\nJson反序列化(result): \r\n\(self)")
                #endif
                
            default:
                #if DEBUG
                    print("\r\nJson反序列化(未實作的Type): \r\n\(type(of: jsonObject))")
                #endif
            }
        }
        catch let error
        {
            #if DEBUG
                print("\r\nJson反序列化(catch error): \r\n\(error.localizedDescription)")
            #endif
        }
    }
    
    /// Json Value to String
    ///
    /// - parameter value:        value description
    /// - parameter defaultValue: defaultValue description
    ///
    /// - returns: return value description
    public func parseString(value: Any?, defaultValue: String = "") -> String
    {
        guard let value = value else {
            return defaultValue
        }
        
        switch value {
        case let value as String:
            return value
            
        case let value as Int:
            return String(value)
            
        case let value as Double:
            return String(value)
            
        default:
            return defaultValue
        }
    }
    
    /// Json Value to String Array
    ///
    /// - parameter value:        value description
    /// - parameter defaultValue: defaultValue description
    ///
    /// - returns: return value description
    public func parseStringArray(value: Any?, defaultValue: [String] = []) -> [String]
    {
        guard let value = value else {
            return defaultValue
        }
        
        switch value {
        case let value as [String]:
            return value
            
        default:
            return defaultValue
        }
    }
    
    /// Json Value to Int
    ///
    /// - parameter value:        value description
    /// - parameter defaultValue: defaultValue description
    ///
    /// - returns: return value description
    public func parseInt(value: Any?, defaultValue: Int = 0) -> Int
    {
        guard let value = value else {
            return defaultValue
        }
        
        switch value {
        case let value as Int:
            return value
            
        case let value as String:
            return Int(value) ?? defaultValue
            
        case let value as Double:
            return Int(value)
            
        default:
            return defaultValue
        }
    }
    
    /// Json Value to Double
    ///
    /// - parameter value:        value description
    /// - parameter defaultValue: defaultValue description
    ///
    /// - returns: return value description
    public func parseDouble(value: Any?, defaultValue: Double = 0.0) -> Double
    {
        guard let value = value else {
            return defaultValue
        }
        
        switch value {
        case let value as Double:
            return value
            
        case let value as Int:
            return Double(value)
            
        case let value as String:
            return Double(value) ?? defaultValue
            
        default:
            return defaultValue
        }
    }
    
    /// Json Value to Bool
    ///
    /// - parameter value:        value description
    /// - parameter defaultValue: defaultValue description
    ///
    /// - returns: return value description
    public func parseBool(value: Any?, defaultValue: Bool = false) -> Bool
    {
        guard let value = value else {
            return defaultValue
        }
        
        switch value {
        case let value as Bool:
            return value
            
        default:
            return defaultValue
        }
    }
}
