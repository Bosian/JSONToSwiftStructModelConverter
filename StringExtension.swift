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
            case _ as String:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): String = \"\""
                
                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")

            case _ as Bool:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): Bool = false"
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case _ as Int:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                let defaultValue = -1
                result += "\(tabSpace)public var \(swiftProperty): Int = \(defaultValue)"
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case _ as Double:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): Double = 0.0"
                
                pendingInit.append((key: swiftProperty, type: "Double"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleOrDefault")
                
            case _ as [String]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): [String] = []"
                
                pendingInit.append((key: swiftProperty, type: "[String]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringArrayOrDefault")
                
            case _ as [Int]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)public var \(swiftProperty): [Int] = []"
                
                pendingInit.append((key: swiftProperty, type: "[Int]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intArrayOrDefault")
                
            case _ as [Double]:
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
        let result = convertToDecodable(for: dictionaryUnwrapped, withKey: key)
        return result
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
            case _ as String:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                    
                result += "\(tabSpace)let \(swiftProperty): String"
                
                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")

            case _ as Bool:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)let \(swiftProperty): Bool"
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case _ as Int:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                let defaultValue = -1
                result += "\(tabSpace)let \(swiftProperty): Int"
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case _ as Double:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)let \(swiftProperty): Double"
                
                pendingInit.append((key: swiftProperty, type: "Double"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleOrDefault")
                
            case _ as [String]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)let \(swiftProperty): [String]"
                
                pendingInit.append((key: swiftProperty, type: "[String]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringArrayOrDefault")
                
            case _ as [Int]:
                appendComment(result: &result, tabSapce: tabSpace, value: value)
                result += "\(tabSpace)let \(swiftProperty): [Int]"
                
                pendingInit.append((key: swiftProperty, type: "[Int]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intArrayOrDefault")
                
            case _ as [Double]:
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
        let result = convertToEncodableFromPostman(for: arrayUnwrapped, withKey: key)
        return result
    }
    
    /// 將 Postman Dictionary 輸出成 Json String
    ///
    /// - Parameters:
    ///   - dictionary: Json Dictionary
    ///   - key: Root struct Name
    private func convertToEncodableFromPostman(for array: JsonArray, withKey key: String) -> String
    {
        let postmanTuples: [(key: String, value: String, description: String, enabled: Bool)] = array.map { dictionary in

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
        
        var pendingJsonDictionary: [(key: String, value: JsonDictionary)] = []
        var pendingInit: [(key: String, type: String)] = []
        var pendingJsonMapping: [String] = []
        var pendingPropertyMapping: [(swiftProperty: String, jsonKey: String)] = []
        
        // 輸出 struct 開頭
        let typeName = pascalCase(for: key)

        var result = "struct \(typeName): \(Encodable.self) {\r\n" {
            didSet {
                result += "\r\n"
            }
        }
        
        let tabSpace = "    "
        
        for (key, value, description, enabled) in postmanTuples {
            
            let swiftProperty = key // camelCase(for: key)
            let jsonKey = key
            
            pendingPropertyMapping.append((swiftProperty: swiftProperty, jsonKey: jsonKey))
            
            // 註解插入
            appendComment(result: &result, tabSapce: tabSpace, value: value, description: description)

            switch value {
            case _ as String:
                result += "\(tabSpace)let \(swiftProperty): String"
                
                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")

            case _ as Bool:
                result += "\(tabSpace)let \(swiftProperty): Bool"
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case _ as Int:
                
                let defaultValue = -1
                result += "\(tabSpace)let \(swiftProperty): Int"
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case _ as Double:
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

            if value is String {
                comment += "e.g. \"\(value)\""
            } else {
                comment += "e.g. \(value)"
            }

            return comment
        }()
    }
}
