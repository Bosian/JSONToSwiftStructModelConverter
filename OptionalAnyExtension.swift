//
//  JsonDictionaryExtension.swift
//  Library
//
//  Created by 劉柏賢 on 2017/6/22.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

// MARK: - For JsonDictionary
extension Optional where Wrapped == Any {
    
    /// Json Value to String
    public var string: String?
    {
        guard let value = self else {
            return nil
        }

        switch value {
        case let value as String:
            return value
            
        case let value as Int:
            return String(value)
            
        case let value as Double:
            return String(value)
            
        default:
            return nil
        }
    }
    
    /// Json Value to String
    public var stringOrDefault: String
    {
        guard let value = self else {
            return ""
        }
        
        switch value {
        case let value as String:
            return value
            
        case let value as Int:
            return String(value)
            
        case let value as Double:
            return String(value)
            
        default:
            return ""
        }
    }
    
    /// Json Value to String Array
    public var stringArray: [String]?
    {
        guard let value = self else {
            return nil
        }
        
        switch value {
        case let value as [String]:
            return value
            
        default:
            return nil
        }
    }
    
    /// Json Value to String Array
    public var stringArrayOrDefault: [String]
    {
        guard let value = self else {
            return []
        }
        
        switch value {
        case let value as [String]:
            return value
            
        default:
            return []
        }
    }

    
    /// Json Value to Int
    public var int: Int?
    {
        guard let value = self else {
            return nil
        }
        
        switch value {
        case let value as Int:
            return value
            
        case let value as String:
            return Int(value)
            
        case let value as Double:
            return Int(value)
            
        default:
            return nil
        }
    }
    
    public var intOrDefault: Int
    {
        guard let value = self else {
            return 0
        }
        
        switch value {
        case let value as Int:
            return value
            
        case let value as String:
            return Int(value) ?? 0
            
        case let value as Double:
            return Int(value)
            
        default:
            return 0
        }
    }

    
    /// Json Value to Double
    public var double: Double?
    {
        guard let value = self else {
            return nil
        }
        
        switch value {
        case let value as Double:
            return value
            
        case let value as Int:
            return Double(value)
            
        case let value as String:
            return Double(value)
            
        default:
            return nil
        }
    }
    
    /// Json Value to Double
    public var doubleOrDefault: Double
    {
        guard let value = self else {
            return 0.0
        }
        
        switch value {
        case let value as Double:
            return value
            
        case let value as Int:
            return Double(value)
            
        case let value as String:
            return Double(value) ?? 0.0
            
        default:
            return 0.0
        }
    }
    
    /// Json Value to Bool
    public var bool: Bool?
    {
        guard let value = self else {
            return nil
        }
        
        switch value {
        case let value as Bool:
            return value
            
        case let value as String:
            return Int(value) != 0
            
        default:
            return nil
        }
    }
    
    /// Json Value to Bool
    public var boolOrDefault: Bool
    {
        guard let value = self else {
            return false
        }
        
        switch value {
        case let value as Bool:
            return value
            
        case let value as String:
            return Int(value) != 0
            
        default:
            return false
        }
    }
    
    public var jsonArray: JsonArray?
    {
        guard let value = self else {
            return nil
        }
        
        return value as? JsonArray
    }
    
    public var jsonArrayOrDefault: JsonArray
    {
        guard let value = self else {
            return JsonArray()
        }
        
        return value as? JsonArray ?? JsonArray()
    }
    
    public var jsonDictionary: JsonDictionary?
    {
        guard let value = self else {
            return nil
        }
        
        return value as? JsonDictionary
    }
    
    public var jsonDictionaryOrDefault: JsonDictionary
    {
        guard let value = self else {
            return JsonDictionary()
        }
        
        return value as? JsonDictionary ?? JsonDictionary()
    }
}
