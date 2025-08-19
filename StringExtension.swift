//
//  StringExtension.swift
//  JsonConverterTest
//
//  Created by 劉柏賢 on 2018/1/28.
//  Copyright © 2018年 劉柏賢. All rights reserved.
//

import Foundation

/// MARK: - Swift JsonDeserialziation
extension String {
    public var jsonModel: String
    {
        let jsonString = self
        guard let data = jsonString.data(using: .utf8) else {
            return ""
        }
        
        var dictionary: JsonDictionary?
        
        do {
            dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? JsonDictionary
        }
        catch let error
        {
            print(error.localizedDescription)
            return ""
        }
        
        guard let dictionaryUnwrapped = dictionary else {
            return ""
        }
        
        let key = "Root"
        let result = convertToModel(for: dictionaryUnwrapped, withKey: key)
        return result
    }
    
    /// 將 Dictionary 輸出成 Json String
    ///
    /// - Parameters:
    ///   - dictionary: Json Dictionary
    ///   - key: Root struct Name
    private func convertToModel(for dictionary: JsonDictionary, withKey key: String) -> String
    {
        var result = "" {
            didSet {
                result += "\r\n"
            }
        }
        
        var pendingJsonDictionary: [(key: String, value: JsonDictionary)] = []
        var pendingInit: [(key: String, type: String)] = []
        var pendingJsonMapping: [String] = []
        var pendingPropertyMapping: [(swiftProperty: String, jsonKey: String)] = []
        
        // 輸出 struct 開頭
        let typeName = pascalCase(for: key)
        result += "public struct \(typeName): \(JsonDeserializeable.self), \(JsonSerializeable.self), \(PropertyMapping.self) {\r\n"
        
        let tabSpace = "    "
        
        for (key, value) in dictionary {
            
            let swiftProperty = camelCase(for: key)
            let jsonKey = key
            
            pendingPropertyMapping.append((swiftProperty: swiftProperty, jsonKey: jsonKey))
            
            switch value {
            case is String:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): String = \"\""
                
                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")

            case let value as NSNumber where value === kCFBooleanTrue || value === kCFBooleanFalse: // https://stackoverflow.com/questions/53547595/type-checks-on-int-and-bool-values-are-returning-incorrectly-in-swift-4-2

                // is Bool
                appendComment(result: &result, tabSapce: tabSpace, value: value.boolValue)
                result += "\(tabSpace)public var \(swiftProperty): Bool = false"
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case is Int:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                let defaultValue = -1
                result += "\(tabSpace)public var \(swiftProperty): Int = \(defaultValue)"
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case is Double:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): Double = 0.0"
                
                pendingInit.append((key: swiftProperty, type: "Double"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleOrDefault")
                
            case is [String]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): [String] = []"
                
                pendingInit.append((key: swiftProperty, type: "[String]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringArrayOrDefault")
                
            case is [Int]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): [Int] = []"
                
                pendingInit.append((key: swiftProperty, type: "[Int]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intArrayOrDefault")
                
            case is [Double]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): [Double] = []"
                
                pendingInit.append((key: swiftProperty, type: "[Double]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleArrayOrDefault")
                
            case let value as JsonDictionary:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                result += "\(tabSpace)public var \(swiftProperty): \(typeName) = \(typeName)()"
                
                pendingInit.append((key: swiftProperty, type: "\(typeName)"))
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = \(typeName)(jsonDictionary: jsonDictionary[\"\(jsonKey)\"].jsonDictionaryOrDefault)")
                
                
            case let value as JsonArray:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                result += "\(tabSpace)public var \(swiftProperty): [\(typeName)] = []"
                
                pendingInit.append((key: swiftProperty, type: "[\(typeName)]"))
                
                guard let value = value.first else {
                    continue
                }
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = [\(typeName)](jsonArray: jsonDictionary[\"\(jsonKey)\"].jsonArrayOrDefault)")
                
            default:
                result += "\(tabSpace)public var \(swiftProperty): Any? = nil"
                
                pendingInit.append((key: swiftProperty, type: "Any?"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"]")
            }
        }
        
        // 輸出 JsonDeserializeable 實作
        result += ""
        result += "\(tabSpace)public init()"
        result += "\(tabSpace){"
        result += "\(tabSpace)"
        result += "\(tabSpace)}"
        
        result += "\(tabSpace)"
        
        result += "\(tabSpace)public init(\(pendingInit.map { "\($0.key): \($0.type)" }.joined(separator: ", ")))"
        result += "\(tabSpace){"
        
        for item in pendingInit {
            result += "\(tabSpace)\(tabSpace)self.\(item.key) = \(item.key)"
        }
        result += "\(tabSpace)}"
        
        result += "\(tabSpace)"
        
        result += "\(tabSpace)public mutating func jsonMapping(_ jsonDictionary: JsonDictionary)"
        result += "\(tabSpace){"
        
        for item in pendingJsonMapping {
            result += "\(tabSpace)\(tabSpace)\(item)"
        }
        
        result += "\(tabSpace)}"
        
        result += ""
        
        result += "\(tabSpace)public func propertyMapping() -> [(String?, String?)]"
        result += "\(tabSpace){"
        
        result += "\(tabSpace)\(tabSpace)let mapping: [(String?, String?)] = ["
        
        for item in pendingPropertyMapping {
            result += "\(tabSpace)\(tabSpace)\(tabSpace)(\"\(item.swiftProperty)\", \"\(item.jsonKey)\"),"
        }
        
        result += "\(tabSpace)\(tabSpace)]"
        result += ""
        result += "\(tabSpace)\(tabSpace)return mapping"
        
        result += "\(tabSpace)}"
        
        // 輸出 struct 後大刮號
        result += "}\r\n"
        
        for (key, dictionary) in pendingJsonDictionary {
            result += convertToModel(for: dictionary, withKey: key)
        }
        
        return result
    }
}

/// MARK: - Swift 4 Decodable
extension String {

    public var jsonDecodableModel: String
    {
        let jsonString = self
        guard let data = jsonString.data(using: .utf8) else {
            return ""
        }

        let key: String = "Root"
        
        do {
            switch try JSONSerialization.jsonObject(with: data, options: []) {
                case let value as JsonDictionary:
                    return convertToDecodable(for: value, withKey: key)
                    
                case let value as JsonArray:
                    
                    guard let value = value.first else { return "" }
                    return convertToDecodable(for: value, withKey: key)
                    
                default:
                    return ""
            }
        }
        catch let error
        {
            print(error.localizedDescription)
            return ""
        }
    }

    /// 將 Dictionary 輸出成 Json String
    ///
    /// - Parameters:
    ///   - dictionary: Json Dictionary
    ///   - key: Root struct Name
    private func convertToDecodable(for dictionary: JsonDictionary, withKey key: String) -> String
    {
        
        var pendingJsonDictionary: [(key: String, value: JsonDictionary)] = []
        var pendingInit: [(key: String, type: String)] = []
        var pendingJsonMapping: [String] = []
        var pendingPropertyMapping: [(swiftProperty: String, jsonKey: String)] = []
        
        // 輸出 struct 開頭
        let typeName = pascalCase(for: key)

        var result = "struct \(typeName): \(Decodable.self) {\r\n" {
            didSet {
                result += "\r\n"
            }
        }
        
        let tabSpace = "    "
        
        for (key, value) in dictionary {
            
            let swiftProperty = key // camelCase(for: key)
            let jsonKey = key
            
            pendingPropertyMapping.append((swiftProperty: swiftProperty, jsonKey: jsonKey))
            
            switch value {
            case is String:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                    
                result += "\(tabSpace)let \(swiftProperty): String"
                
                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")

            case let value as NSNumber where value === kCFBooleanTrue || value === kCFBooleanFalse: // https://stackoverflow.com/questions/53547595/type-checks-on-int-and-bool-values-are-returning-incorrectly-in-swift-4-2

                // is Bool
                appendComment(result: &result, tabSapce: tabSpace, value: value.boolValue)
                result += "\(tabSpace)let \(swiftProperty): Bool"
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case is Int:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                    _ = -1
                result += "\(tabSpace)let \(swiftProperty): Int"
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case is Double:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)let \(swiftProperty): Double"
                
                pendingInit.append((key: swiftProperty, type: "Double"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleOrDefault")
                
            case is [String]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)let \(swiftProperty): [String]"
                
                pendingInit.append((key: swiftProperty, type: "[String]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringArrayOrDefault")
                
            case is [Int]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)let \(swiftProperty): [Int]"
                
                pendingInit.append((key: swiftProperty, type: "[Int]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intArrayOrDefault")
                
            case is [Double]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)let \(swiftProperty): [Double]"
                
                pendingInit.append((key: swiftProperty, type: "[Double]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleArrayOrDefault")
                
            case let value as JsonDictionary:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                result += "\(tabSpace)let \(swiftProperty): \(typeName)"
                
                pendingInit.append((key: swiftProperty, type: "\(typeName)"))
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = \(typeName)(jsonDictionary: jsonDictionary[\"\(jsonKey)\"].jsonDictionaryOrDefault)")
                
                
            case let value as JsonArray:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                result += "\(tabSpace)let \(swiftProperty): [\(typeName)]"
                
                pendingInit.append((key: swiftProperty, type: "[\(typeName)]"))
                
                guard let value = value.first else {
                    continue
                }
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = [\(typeName)](jsonArray: jsonDictionary[\"\(jsonKey)\"].jsonArrayOrDefault)")
                
            default:
                result += "\(tabSpace)let \(swiftProperty): Any?"
                
                pendingInit.append((key: swiftProperty, type: "Any?"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"]")
            }
        }
        
        // 輸出 struct 後大刮號
        result += "}\r\n"
        
        for (key, dictionary) in pendingJsonDictionary {
            result += convertToDecodable(for: dictionary, withKey: key)
        }
        
        return result
    }
}

/// MARK: - Swift 4 Decodable with default
extension String {

    public var jsonDecodableWithDefaultModel: String
    {
        let jsonString = self
        guard let data = jsonString.data(using: .utf8) else {
            return ""
        }

        let key: String = "Root"
        
        do {
            switch try JSONSerialization.jsonObject(with: data, options: []) {
                case let value as JsonDictionary:
                    return convertToDecodableWithDefault(for: value, withKey: key)
                    
                case let value as JsonArray:
                    
                    guard let value = value.first else { return "" }
                    return convertToDecodableWithDefault(for: value, withKey: key)
                    
                default:
                    return ""
            }
        }
        catch let error
        {
            print(error.localizedDescription)
            return ""
        }
    }

    /// 將 Dictionary 輸出成 Json String
    ///
    /// - Parameters:
    ///   - dictionary: Json Dictionary
    ///   - key: Root struct Name
    private func convertToDecodableWithDefault(for dictionary: JsonDictionary, withKey key: String) -> String
    {
        
        var pendingJsonDictionary: [(key: String, value: JsonDictionary)] = []
        var pendingInit: [(key: String, type: String)] = []
        var pendingJsonMapping: [String] = []
        var pendingPropertyMapping: [(swiftProperty: String, jsonKey: String)] = []
        
        // 輸出 struct 開頭
        let typeName = pascalCase(for: key)

        var result = "struct \(typeName): \(Decodable.self) {\r\n" {
            didSet {
                result += "\r\n"
            }
        }
        
        let tabSpace = "    "
        
        for (key, value) in dictionary {
            
            let swiftProperty = key // camelCase(for: key)
            let jsonKey = key
            
            pendingPropertyMapping.append((swiftProperty: swiftProperty, jsonKey: jsonKey))
            
            switch value {
            case is String:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                    
                result += "\(tabSpace)@Default.EmptyString"
                result += "\(tabSpace)var \(swiftProperty): String"
                
                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")

            case let value as NSNumber where value === kCFBooleanTrue || value === kCFBooleanFalse: // https://stackoverflow.com/questions/53547595/type-checks-on-int-and-bool-values-are-returning-incorrectly-in-swift-4-2

                // is Bool
                appendComment(result: &result, tabSapce: tabSpace, value: value.boolValue)
                result += "\(tabSpace)@Default.False"
                result += "\(tabSpace)var \(swiftProperty): Bool"
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case is Int:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                _ = -1
                result += "\(tabSpace)@Default.ZeroInt"
                result += "\(tabSpace)var \(swiftProperty): Int"
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case is Double:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)@Default.ZeroDouble"
                result += "\(tabSpace)var \(swiftProperty): Double"
                
                pendingInit.append((key: swiftProperty, type: "Double"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleOrDefault")
                
            case is [String]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)@Default.EmptyStringArray"
                result += "\(tabSpace)var \(swiftProperty): [String]"
                
                pendingInit.append((key: swiftProperty, type: "[String]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringArrayOrDefault")
                
            case is [Int]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)@Default<Array.Empty>"
                result += "\(tabSpace)var \(swiftProperty): [Int]"
                
                pendingInit.append((key: swiftProperty, type: "[Int]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intArrayOrDefault")
                
            case is [Double]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)@Default<Array.Empty>"
                result += "\(tabSpace)var \(swiftProperty): [Double]"
                
                pendingInit.append((key: swiftProperty, type: "[Double]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleArrayOrDefault")
                
            case let value as JsonDictionary:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                result += "\(tabSpace)@Default<Optional.Nil>"
                result += "\(tabSpace)var \(swiftProperty): \(typeName)?"
                
                pendingInit.append((key: swiftProperty, type: "\(typeName)"))
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = \(typeName)(jsonDictionary: jsonDictionary[\"\(jsonKey)\"].jsonDictionaryOrDefault)")
                
                
            case let value as JsonArray:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                result += "\(tabSpace)@Default<Array.Empty>"
                result += "\(tabSpace)var \(swiftProperty): [\(typeName)]"
                
                pendingInit.append((key: swiftProperty, type: "[\(typeName)]"))
                
                guard let value = value.first else {
                    continue
                }
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = [\(typeName)](jsonArray: jsonDictionary[\"\(jsonKey)\"].jsonArrayOrDefault)")
                
            default:
                result += "\(tabSpace)@Default<Optional.Nil>"
                result += "\(tabSpace)var \(swiftProperty): Any?"
                
                pendingInit.append((key: swiftProperty, type: "Any?"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"]")
            }
        }
        
        // 輸出 struct 後大刮號
        result += "}\r\n"
        
        for (key, dictionary) in pendingJsonDictionary {
            result += convertToDecodableWithDefault(for: dictionary, withKey: key)
        }
        
        return result
    }
}

/// Mark: - From postman params
extension String {
    
    var jsonFromPostmanParams: String {
        let jsonString = self
        guard let data = jsonString.data(using: .utf8) else {
            return ""
        }
        
        var array: JsonArray?
        
        do {
            array = try JSONSerialization.jsonObject(with: data, options: []) as? JsonArray
        }
        catch let error
        {
            print(error.localizedDescription)
            return ""
        }
        
        guard let arrayUnwrapped = array else {
            return ""
        }
        
        let key = "Root"
        let result = convertToEncodableFromPostman(for: arrayUnwrapped, withKey: key, superType: Encodable.self)
        return result
    }
    
    /// 將 Postman Dictionary 輸出成 Json String
    ///
    /// - Parameters:
    ///   - dictionary: Json Dictionary
    ///   - key: Root struct Name
    private func convertToEncodableFromPostman<T>(for array: JsonArray, withKey key: String, superType: T) -> String
    {
        let postmanTuples: [(key: String, value: String, description: String, enabenabled: Bool)] = array.map { dictionary in

            var key: String = ""
            var value: String = ""
            var description: String = ""
            var enabled: Bool = false
            
            for (postmanKey, postmanValue) in dictionary {
                
                let postmanValue: Any? = postmanValue
                switch postmanKey {
                    case "key":
                        key = postmanValue.stringOrDefault
                        
                    case "value":
                        value = postmanValue.stringOrDefault
                        
                    case "description":
                        description = postmanValue.stringOrDefault
                        
                    case "enabled":
                        enabled = postmanValue.boolOrDefault
                        
                    default:
                        break
                }
            }
            
            return (key, value, description, enabled)
        }
        
        let pendingJsonDictionary: [(key: String, value: JsonDictionary)] = []
        var pendingInit: [(key: String, type: String)] = []
        var pendingJsonMapping: [String] = []
        var pendingPropertyMapping: [(swiftProperty: String, jsonKey: String)] = []
        
        // 輸出 struct 開頭
        let typeName = pascalCase(for: key)

        var result = "struct \(typeName): \(T.self) {\r\n" {
            didSet {
                result += "\r\n"
            }
        }
        
        let tabSpace = "    "
        
        for (key, value, description, _) in postmanTuples {
            
            let swiftProperty = key // camelCase(for: key)
            let jsonKey = key
            
            pendingPropertyMapping.append((swiftProperty: swiftProperty, jsonKey: jsonKey))
            
            // 註解插入
            appendComment(result: &result, tabSapce: tabSpace, value: value, description: description)

            switch value {
            case is String:
                result += "\(tabSpace)let \(swiftProperty): String"
                
                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")

            case is Bool:
                result += "\(tabSpace)let \(swiftProperty): Bool"
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case is Int:
                
                    _ = -1
                result += "\(tabSpace)let \(swiftProperty): Int"
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case is Double:
                result += "\(tabSpace)let \(swiftProperty): Double"
                
                pendingInit.append((key: swiftProperty, type: "Double"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleOrDefault")
                
            default:
                result += "\(tabSpace)let \(swiftProperty): Any?"
                
                pendingInit.append((key: swiftProperty, type: "Any?"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"]")
            }
        }
        
        // 輸出 struct 後大刮號
        result += "}\r\n"
        
        for (key, dictionary) in pendingJsonDictionary {
            result += convertToDecodable(for: dictionary, withKey: key)
        }
        
        return result
    }
}

extension String {

    /// 首字轉大寫
    ///
    /// - Parameter str: 字串
    /// - Returns: 回傳首字轉大寫後字串
    fileprivate func uppercaseedFirstChar(for str: String?) -> String
    {
        guard let str = str else {
            return ""
        }
        
        guard let firstChar = str.first else {
            return ""
        }
        
        // struct name 首字大寫
        let firstCharUppercased = String(firstChar).uppercased()
        
        let index = str.index(str.startIndex, offsetBy: 1)
        let othersKeyChar = str[index...]
        
        return "\(firstCharUppercased)\(othersKeyChar)"
    }
    
    /// 首字轉小寫
    ///
    /// - Parameter str: 字串
    /// - Returns: 回傳首字轉小寫後字串
    fileprivate func lowercaseedFirstChar(for str: String?) -> String
    {
        guard let str = str else {
            return ""
        }
        
        guard let firstChar = str.first else {
            return ""
        }
        
        // struct name 首字小寫
        let firstCharLowercased = String(firstChar).lowercased()
        let index = str.index(str.startIndex, offsetBy: 1)
        let othersKeyChar = str[index...]
        
        return "\(firstCharLowercased)\(othersKeyChar)"
    }
    
    /// 小駝峰式命名法（lower camel case）
    fileprivate func camelCase(for str: String) -> String {
        
        let stringArray = str.replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "-", with: "_")
            .components(separatedBy: "_")
        
        // 首字轉小寫
        let firstWord = lowercaseedFirstChar(for: stringArray.first)
        
        // 單字小於3個字母則全轉大寫
        var otherStringArray = stringArray.dropFirst().map { uppercaseedFirstChar(for: $0) }
        otherStringArray.insert(firstWord, at: 0)
        
        return otherStringArray.joined()
    }
    
    /// Pascal命名法（Pascal Case)
    fileprivate func pascalCase(for str: String) -> String {
        
        let stringArray = str.replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "-", with: "_")
            .components(separatedBy: "_")
        
        // 首字轉大寫
        let firstWord = uppercaseedFirstChar(for: stringArray.first)
        
        // 單字小於3個字母則全轉大寫
        var otherStringArray = stringArray.dropFirst().map { uppercaseedFirstChar(for: $0)}
        otherStringArray.insert(firstWord, at: 0)
        
        return otherStringArray.joined()
    }

    /// 註解插入
    fileprivate func appendComment<T>(result: inout String, tabSapce: String, value: T, description: String = "") {
        result += {
            var comment: String = "\r\n\(tabSapce)/// "
            print(comment)

            switch value {
                case let value as String:
                    comment += "e.g. \"\(value)\""
                    
                case let value as [String]:
                    let value = value.joined(separator: "\", \"")
                    comment += "e.g. [\"\(value)\"]"
                    
                case let value as [Int]:
                    let value: [String] = value.map({ (item: Int) -> String in
                        return String(item)
                    })
                    comment += "e.g. [\(value.joined(separator: ", "))]"
                    
                case let value as [Double]:
                    let value: [String] = value.map({ (item: Double) -> String in
                        return String(item)
                    })
                    comment += "e.g. [\(value.joined(separator: ", "))]"

                default:
                    comment += "e.g. \(value)"
            }

            return comment
        }()
    }
}

/// MARK: - Generate Unit test
extension String {

    /// 產生Unit test
    var generateUnitTest: String {

        let jsonString = self
        guard let data = jsonString.data(using: .utf8) else {
            return ""
        }

        let key: String = "Root"
        
        do {
            switch try JSONSerialization.jsonObject(with: data, options: []) {
                case let value as JsonDictionary:
                    return convertToXCTest(for: value, withKey: key)
                    
                case let value as JsonArray:
                    
                    guard let value = value.first else { return "" }
                    return convertToXCTest(for: value, withKey: key)
                    
                default:
                    return ""
            }
        }
        catch let error
        {
            print(error.localizedDescription)
            return ""
        }
    }

    private func nestedXCTest(for dictionary: JsonDictionary, withKey key: String, tabSpace: String = "    ") -> String {

        var result: String = "" {
            didSet {
                result += "\r\n"
            }
        }
        
        for (swiftProperty, value) in dictionary {
            switch value {
                case is String:
                    // XCTAssertTrue(!\(key).message.isEmpty)
                    result += "\(tabSpace)XCTAssertTrue(!\(key).\(swiftProperty).isEmpty)"
                    
                case let value as NSNumber where value === kCFBooleanTrue || value === kCFBooleanFalse: // https://stackoverflow.com/questions/53547595/type-checks-on-int-and-bool-values-are-returning-incorrectly-in-swift-4-2

                    // is Bool
                    result += "\(tabSpace)XCTAssertTrue(!\(key).\(swiftProperty))"
                    
                case is Int:
                    // XCTAssertTrue(item.position > -1)
                    result += "\(tabSpace)XCTAssertTrue(\(key).\(swiftProperty) > 0)"
                    
                case is Double:
                    result += "\(tabSpace)XCTAssertTrue(\(key).\(swiftProperty) > 0.0)"
                    
                case is [String]:
                    result += "\(tabSpace)XCTAssertTrue(!\(key).\(swiftProperty).isEmpty)"
                    
                case is [Int]:
                    result += "\(tabSpace)XCTAssertTrue(!\(key).\(swiftProperty).isEmpty)"
                    
                case is [Double]:
                    result += "\(tabSpace)XCTAssertTrue(!\(key).\(swiftProperty).isEmpty)"
                    
                case let value as JsonDictionary:
                    result += nestedXCTest(for: value, withKey: "\(key).\(swiftProperty)", tabSpace: tabSpace)
                    
                case let value as JsonArray:
                    
                    result += "\(tabSpace)XCTAssertTrue(!\(key).\(swiftProperty).isEmpty)"
                    
                    guard let value = value.first else {
                        continue
                    }

                    let loopName: String = "item"
                    result += "\r\n\(tabSpace)for \(loopName) in \(key).\(swiftProperty) {"
                    
                    result += nestedXCTest(for: value, withKey: loopName, tabSpace: tabSpace + tabSpace)
                    
                    result += "\(tabSpace)}"
                    
                case is NSNull:
                    result += "\(tabSpace)XCTAssertNotNil(\(key).\(swiftProperty))"

                default:
                    result += "\(tabSpace)XCTAssertTrue(!\(key).\(swiftProperty).isEmpty)"
            }
        }
        
        return result
    }

    private func convertToXCTest(for dictionary: JsonDictionary, withKey key: String) -> String
    {
        // 輸出 struct 開頭
        let typeName = pascalCase(for: key)

        var result = "func test\(typeName)() async throws {\r\n"

        result += nestedXCTest(for: dictionary, withKey: "model")
        
        // 輸出 struct 後大刮號
        result += "}\r\n"
        
        return result
    }
}

/// MARK: - Generate SwiftTesting
extension String {

    /// 產生基於 SwiftTesting Unit test
    var generateSwiftTestingUnitTest: String {

        let jsonString = self
        guard let data = jsonString.data(using: .utf8) else {
            return ""
        }

        let key: String = "Root"
        
        do {
            switch try JSONSerialization.jsonObject(with: data, options: []) {
                case let value as JsonDictionary:
                    return convertToSwiftTesting(for: value, withKey: key)
                    
                case let value as JsonArray:
                    
                    guard let value = value.first else { return "" }
                    return convertToSwiftTesting(for: value, withKey: key)
                    
                default:
                    return ""
            }
        }
        catch let error
        {
            print(error.localizedDescription)
            return ""
        }
    }

    private func nestedSwiftTesting(for dictionary: JsonDictionary, withKey key: String, tabSpace: String = "    ") -> String {

        var result: String = "" {
            didSet {
                result += "\r\n"
            }
        }
        
        for (swiftProperty, value) in dictionary {
            switch value {
                case is String:
                    // #expect(!\(key).message.isEmpty)
                    result += "\(tabSpace)#expect(!\(key).\(swiftProperty).isEmpty)"
                    
                case let value as NSNumber where value === kCFBooleanTrue || value === kCFBooleanFalse: // https://stackoverflow.com/questions/53547595/type-checks-on-int-and-bool-values-are-returning-incorrectly-in-swift-4-2

                    // is Bool
                    result += "\(tabSpace)#expect(!\(key).\(swiftProperty))"
                    
                case is Int:
                    // #expect(item.position > -1)
                    result += "\(tabSpace)#expect(\(key).\(swiftProperty) > 0)"
                    
                case is Double:
                    result += "\(tabSpace)#expect(\(key).\(swiftProperty) > 0.0)"
                    
                case is [String]:
                    result += "\(tabSpace)#expect(!\(key).\(swiftProperty).isEmpty)"
                    
                case is [Int]:
                    result += "\(tabSpace)#expect(!\(key).\(swiftProperty).isEmpty)"
                    
                case is [Double]:
                    result += "\(tabSpace)#expect(!\(key).\(swiftProperty).isEmpty)"
                    
                case let value as JsonDictionary:
                    result += nestedSwiftTesting(for: value, withKey: "\(key).\(swiftProperty)", tabSpace: tabSpace)
                    
                case let value as JsonArray:
                    
                    result += "\(tabSpace)#expect(!\(key).\(swiftProperty).isEmpty)"
                    
                    guard let value = value.first else {
                        continue
                    }

                    let loopName: String = "item"
                    result += "\r\n\(tabSpace)for \(loopName) in \(key).\(swiftProperty) {"
                    
                    result += nestedSwiftTesting(for: value, withKey: loopName, tabSpace: tabSpace + tabSpace)
                    
                    result += "\(tabSpace)}"
                    
                case is NSNull:
                    result += "\(tabSpace)#expect(\(key).\(swiftProperty) != nil)"

                default:
                    result += "\(tabSpace)#expect(!\(key).\(swiftProperty).isEmpty)"
            }
        }
        
        return result
    }

    private func convertToSwiftTesting(for dictionary: JsonDictionary, withKey key: String) -> String
    {
        // 輸出 struct 開頭
        let typeName = pascalCase(for: key)

        var result = "@Test func test\(typeName)() async throws {\r\n"

        result += nestedSwiftTesting(for: dictionary, withKey: "model")
        
        // 輸出 struct 後大刮號
        result += "}\r\n"
        
        return result
    }
}


/// @Default library
extension String {
    static var defaultLibrary: String {
        return #"""

            extension CGFloat {
                init?(_ value: String) {
                    guard let doubleValue = Double(value) else {
                        return nil
                    }
                    
                    self = CGFloat(doubleValue)
                }
            }

            extension String {
                init(_ value: CGFloat) {
                    self = "\(value)"
                }
            }
            
            protocol DefaultValue {
                associatedtype Value: Decodable
                static var defaultValue: Value { get }
            }

            extension Int {
                struct Zero: DefaultValue {
                    static var defaultValue: Int { 0 }
                }
            }

            extension Bool {

                struct True: DefaultValue {
                    static var defaultValue: Bool { true }
                }
                
                struct False: DefaultValue {
                    static var defaultValue: Bool { false }
                }

            }

            extension Double {
                struct Zero: DefaultValue {
                    static var defaultValue: Double { 0.0 }
                }
            }

            extension CGFloat {
                struct Zero: DefaultValue {
                    static var defaultValue: CGFloat { 0.0 }
                }
            }

            extension String {
                struct Empty: DefaultValue {
                    static var defaultValue: String { "" }
                }
            }

            extension Array where Element: Decodable {
                
                
                /// 解失敗給預設值 []
                /// ```
                /// @Default<Array.Empty> or @Default<Array.Empty>
                /// var model: [Model]
                /// ```
                struct Empty: DefaultValue {
                    static var defaultValue: Array<Element> { [] }
                }
            }

            /// 用在JSON 反序列化 (套在欲decode的屬性上)
            ///  ```
            /// @Default<[Model]> or @Default<Array.Empty>
            /// var model: [Model]
            ///  ```
            ///
            ///  ```
            /// /// e.g. 123123
            /// @Default<String> or @Default.EmptyString
            /// var article_id: String
            ///  ```
            /// - 支援 Int, Bool, Double, CGFloat, String, Array
            /// - 找不到key，設成預設值
            /// - 型態不符(String, Int, Double, CGFloat)，會嘗試轉型
            @propertyWrapper
            struct Default<T: DefaultValue> {
                var wrappedValue: T.Value
            }

            /// MARK - 縮短泛型方便使用
            extension Default {
                typealias True = Default<Bool.True>
                typealias False = Default<Bool.False>
                typealias EmptyString = Default<String.Empty>
                typealias ZeroInt = Default<Int.Zero>
                typealias ZeroDouble = Default<Double.Zero>
                typealias ZeroCGFloat = Default<CGFloat.Zero>
                typealias EmptyStringArray = Default<Array<String>.Empty>
            }

            extension Optional where Wrapped: Decodable {
                struct Nil: DefaultValue {
                    static var defaultValue: Wrapped? { nil }
                }
            }

            // Compile 成功，但實際使用是Compile error => @Default.Nil
            //extension Default where T.Value: OptionalType {
            //    typealias Nil = Default<Optional<T.Value>.Nil>
            //}

            extension Default: Encodable where T.Value: Encodable {
                func encode(to encoder: any Encoder) throws {
                    var container = encoder.singleValueContainer()
                    try container.encode(wrappedValue)
                }
            }

            extension Default: Decodable {

                init(from decoder: Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    
                    wrappedValue = {
                        switch T.Value.self {
                            case is String.Type, is Optional<String>.Type:
                                
                                // Int, Double to Stirng
                                let value: String? = {
                                    if let value = (try? container.decode(String.self)) {
                                        return value
                                    } else if let value = (try? container.decode(Int.self)) {
                                        return String(value)
                                    } else if let value = (try? container.decode(Double.self)) {
                                        return String(value)
                                    } else {
                                        return nil
                                    }
                                }()
                                
                                return value as? T.Value ?? T.defaultValue // 轉型失敗有預設值
                                
                            case is Int.Type, is Optional<Int>.Type:

                                // Stirng, Double to Int
                                let value: Int? = {
                                    if let value = (try? container.decode(Int.self)) {
                                        return value
                                    } else if let value = (try? container.decode(String.self)) {
                                        return Int(value) ?? {
                                            guard let double = Double(value) else {
                                                return nil
                                            }
                                            return Int(double)
                                        }()
                                    } else if let value = (try? container.decode(Double.self)) {
                                        return Int(value)
                                    } else {
                                        return nil
                                    }
                                }()
                                
                                return value as? T.Value ?? T.defaultValue // 轉型失敗有預設值
                                
                            case is Double.Type, is Optional<Double>.Type:
                                
                                // Stirng, Int to Double
                                let value: Double? = {
                                    if let value = (try? container.decode(Double.self)) {
                                        return value
                                    } else if let value = (try? container.decode(String.self)) {
                                        return Double(value)
                                    } else if let value = (try? container.decode(Int.self)) {
                                        return Double(value)
                                    } else {
                                        return nil
                                    }
                                }()
                                
                                return value as? T.Value ?? T.defaultValue // 轉型失敗有預設值
                                
                            case is CGFloat.Type, is Optional<CGFloat>.Type:

                                // Stirng, Int to CGFloat
                                let value: CGFloat? = {
                                    if let value = (try? container.decode(CGFloat.self)) {
                                        return value
                                    } else if let value = (try? container.decode(String.self)) {
                                        return CGFloat(value)
                                    } else if let value = (try? container.decode(Int.self)) {
                                        return CGFloat(value)
                                    } else {
                                        return nil
                                    }
                                }()
                                
                                return value as? T.Value ?? T.defaultValue // 轉型失敗有預設值

                            case is Array<String>.Type, is Optional<Array<String>>.Type:
                                
                                // Double, CGFloat, Int to Array<String>
                                let value: Array<String>? = {
                                    if let value = (try? container.decode(Array<String>.self)) {
                                        return value
                                    } else if let value = (try? container.decode(Array<Int>.self)) {
                                        return value.map { (item: Int) -> String in
                                            return String(item)
                                        }
                                    } else if let value = (try? container.decode(Array<CGFloat>.self)) {
                                        return value.map { (item: CGFloat) -> String in
                                            return String(item)
                                        }
                                    } else if let value = (try? container.decode(Array<Double>.self)) {
                                        return value.map { (item: Double) -> String in
                                            return String(item)
                                        }
                                    } else {
                                        return nil
                                    }
                                }()
                                
                                return value as? T.Value ?? T.defaultValue // 轉型失敗有預設值
                                
                            default:
                                return (try? container.decode(T.Value.self)) ?? T.defaultValue // decode失敗有預設值
                        }
                    }()
                }
            }

            extension KeyedDecodingContainer {
                func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
                    
                    // 沒Key時給預設值
                    try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
                }
            }

            /// Decodable decode不用給Type
            extension KeyedDecodingContainer {

                /// 型別容錯 + 預設值 For T
                func decodeIfPresent<T>(forKey key: Key, defaultValue: T) -> T where T: Decodable {
                    return decodeIfPresent(forKey: key) ?? defaultValue
                }
                
                /// 型別容錯 + 預設值 For Optional<T> (不能用非Optional<T>，結果會不正確)
                func decodeIfPresent<T>(forKey key: Key, defaultValue: T) -> T? where T: Decodable {
                    return decodeIfPresent(forKey: key) ?? defaultValue
                }
                
                /// 型別容錯 + nil
                func decodeIfPresent<T>(forKey key: Key) -> T? where T: Decodable {

                    let container = self

                    switch T.self {
                        case is String.Type, is Optional<Int>.Type:
                            
                            // Int, Double to Stirng
                            let value: String? = {
                                if let value = (try? container.decode(String.self, forKey: key)) {
                                    return value
                                } else if let value = (try? container.decode(Int.self, forKey: key)) {
                                    return String(value)
                                } else if let value = (try? container.decode(Double.self, forKey: key)) {
                                    return String(value)
                                } else {
                                    return nil
                                }
                            }()
                            
                            return value as? T
                            
                        case is Int.Type, is Optional<Int>.Type:

                            // Stirng, Double to Int
                            let value: Int? = {
                                if let value = (try? container.decode(Int.self, forKey: key)) {
                                    return value
                                } else if let value = (try? container.decode(String.self, forKey: key)) {
                                    return Int(value) ?? {
                                        guard let double = Double(value) else {
                                            return nil
                                        }
                                        return Int(double)
                                    }()
                                } else if let value = (try? container.decode(Double.self, forKey: key)) {
                                    return Int(value)
                                } else {
                                    return nil
                                }
                            }()
                            
                            return value as? T
                            
                        case is Double.Type, is Optional<Double>.Type:
                            
                            // Stirng, Int to Double
                            let value: Double? = {
                                if let value = (try? container.decode(Double.self, forKey: key)) {
                                    return value
                                } else if let value = (try? container.decode(String.self, forKey: key)) {
                                    return Double(value)
                                } else if let value = (try? container.decode(Int.self, forKey: key)) {
                                    return Double(value)
                                } else {
                                    return nil
                                }
                            }()
                            
                            return value as? T
                            
                        case is CGFloat.Type, is Optional<CGFloat>.Type:

                            // Stirng, Int to CGFloat
                            let value: CGFloat? = {
                                if let value = (try? container.decode(CGFloat.self, forKey: key)) {
                                    return value
                                } else if let value = (try? container.decode(String.self, forKey: key)) {
                                    return CGFloat(value)
                                } else if let value = (try? container.decode(Int.self, forKey: key)) {
                                    return CGFloat(value)
                                } else {
                                    return nil
                                }
                            }()
                            
                            return value as? T

                        case is Array<String>.Type, is Optional<Array<String>>.Type:
                            
                            // Double, CGFloat, Int to Array<String>
                            let value: Array<String>? = {
                                if let value = (try? container.decode(Array<String>.self, forKey: key)) {
                                    return value
                                } else if let value = (try? container.decode(Array<Int>.self, forKey: key)) {
                                    return value.map { (item: Int) -> String in
                                        return String(item)
                                    }
                                } else if let value = (try? container.decode(Array<CGFloat>.self, forKey: key)) {
                                    return value.map { (item: CGFloat) -> String in
                                        return String(item)
                                    }
                                } else if let value = (try? container.decode(Array<Double>.self, forKey: key)) {
                                    return value.map { (item: Double) -> String in
                                        return String(item)
                                    }
                                } else {
                                    return nil
                                }
                            }()
                            
                            return value as? T
                            
                        default:
                            return (try? container.decode(T.self, forKey: key))
                    }
                }
            }
            
            """#
    }
}
