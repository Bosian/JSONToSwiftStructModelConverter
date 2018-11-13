//
//  StringExtension.swift
//  JsonConverterTest
//
//  Created by 劉柏賢 on 2018/1/28.
//  Copyright © 2018年 劉柏賢. All rights reserved.
//

import Foundation

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
        
        let tabSapce = "    "
        
        for (key, value) in dictionary {
            
            let swiftProperty = camelCase(for: key)
            let jsonKey = key
            
            pendingPropertyMapping.append((swiftProperty: swiftProperty, jsonKey: jsonKey))
            
            switch value {
            case _ as String:
                result += "\(tabSapce)public var \(swiftProperty): String = \"\""
                
                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")

            case _ as Bool:
                result += "\(tabSapce)public var \(swiftProperty): Bool = false"
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case _ as Int:
                
                let defaultValue = -1
                result += "\(tabSapce)public var \(swiftProperty): Int = \(defaultValue)"
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case _ as Double:
                result += "\(tabSapce)public var \(swiftProperty): Double = 0.0"
                
                pendingInit.append((key: swiftProperty, type: "Double"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleOrDefault")
                
            case _ as [String]:
                result += "\(tabSapce)public var \(swiftProperty): [String] = []"
                
                pendingInit.append((key: swiftProperty, type: "[String]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringArrayOrDefault")
                
            case _ as [Int]:
                result += "\(tabSapce)public var \(swiftProperty): [Int] = []"
                
                pendingInit.append((key: swiftProperty, type: "[Int]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intArrayOrDefault")
                
            case _ as [Double]:
                result += "\(tabSapce)public var \(swiftProperty): [Double] = []"
                
                pendingInit.append((key: swiftProperty, type: "[Double]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleArrayOrDefault")
                
            case let value as JsonDictionary:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                result += "\(tabSapce)public var \(swiftProperty): \(typeName) = \(typeName)()"
                
                pendingInit.append((key: swiftProperty, type: "\(typeName)"))
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = \(typeName)(jsonDictionary: jsonDictionary[\"\(jsonKey)\"].jsonDictionaryOrDefault)")
                
                
            case let value as JsonArray:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                result += "\(tabSapce)public var \(swiftProperty): [\(typeName)] = []"
                
                pendingInit.append((key: swiftProperty, type: "[\(typeName)]"))
                
                guard let value = value.first else {
                    continue
                }
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = [\(typeName)](jsonArray: jsonDictionary[\"\(jsonKey)\"].jsonArrayOrDefault)")
                
            default:
                result += "\(tabSapce)public var \(swiftProperty): Any? = nil"
                
                pendingInit.append((key: swiftProperty, type: "Any?"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"]")
            }
        }
        
        // 輸出 JsonDeserializeable 實作
        result += ""
        result += "\(tabSapce)public init()"
        result += "\(tabSapce){"
        result += "\(tabSapce)"
        result += "\(tabSapce)}"
        
        result += "\(tabSapce)"
        
        result += "\(tabSapce)public init(\(pendingInit.map { "\($0.key): \($0.type)" }.joined(separator: ", ")))"
        result += "\(tabSapce){"
        
        for item in pendingInit {
            result += "\(tabSapce)\(tabSapce)self.\(item.key) = \(item.key)"
        }
        result += "\(tabSapce)}"
        
        result += "\(tabSapce)"
        
        result += "\(tabSapce)public mutating func jsonMapping(_ jsonDictionary: JsonDictionary)"
        result += "\(tabSapce){"
        
        for item in pendingJsonMapping {
            result += "\(tabSapce)\(tabSapce)\(item)"
        }
        
        result += "\(tabSapce)}"
        
        result += ""
        
        result += "\(tabSapce)public func propertyMapping() -> [(String?, String?)]"
        result += "\(tabSapce){"
        
        result += "\(tabSapce)\(tabSapce)let mapping: [(String?, String?)] = ["
        
        for item in pendingPropertyMapping {
            result += "\(tabSapce)\(tabSapce)\(tabSapce)(\"\(item.swiftProperty)\", \"\(item.jsonKey)\"),"
        }
        
        result += "\(tabSapce)\(tabSapce)]"
        result += ""
        result += "\(tabSapce)\(tabSapce)return mapping"
        
        result += "\(tabSapce)}"
        
        // 輸出 struct 後大刮號
        result += "}\r\n"
        
        for (key, dictionary) in pendingJsonDictionary {
            result += convertToModel(for: dictionary, withKey: key)
        }
        
        return result
    }
    
    /// 首字轉大寫
    ///
    /// - Parameter str: 字串
    /// - Returns: 回傳首字轉大寫後字串
    private func uppercaseedFirstChar(for str: String?) -> String
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
    private func lowercaseedFirstChar(for str: String?) -> String
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
    private func camelCase(for str: String) -> String {
        
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
    private func pascalCase(for str: String) -> String {
        
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
}
