//
//  ViewController.swift
//  JsonConverterTest
//
//  Created by 劉柏賢 on 2016/11/1.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonString = "{\"resultCode\":200,\"resultMsg\":\"\",\"lists\":[{\"sasid\":1,\"rid\":\"12345\",\"time\":\"2016/12/31 19:30\",\"title\":\"Mr.\",\"lastName\":\"方\",\"adult\":4,\"child\":2,\"language\":\"zh\",\"orderStatus\":0,\"replyStatus\":1,\"requirement\":{\"id\":1,\"title\":\"海德格\",\"dataAray\":[\"a\",\"b\"]}},{\"sasid\":2,\"rid\":\"23456\",\"time\":\"2016/12/31 19:30\",\"title\":\"Ms.\",\"lastName\":\"木村\",\"adult\":4,\"child\":2,\"language\":\"ja\",\"orderStatus\":6,\"replyStatus\":0}]}"
        guard let data = jsonString.data(using: .utf8) else {
            return
        }
        
        var dictionary: JsonDictionary?
        
        do {
            dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? JsonDictionary
        }
        catch let error
        {
            print(error.localizedDescription)
            return
        }
        
        guard let dictionaryUnwrapped = dictionary else {
            return
        }
        
        let key = "Root"
        convertToModel(for: dictionaryUnwrapped, withKey: key)
    }
    
    
    /// 將 Dictionary 輸出成 Json String
    ///
    /// - Parameters:
    ///   - dictionary: Json Dictionary
    ///   - key: Root struct Name
    private func convertToModel(for dictionary: JsonDictionary, withKey key: String)
    {
        var pendingJsonDictionary: [(key: String, value: JsonDictionary)] = []
        var pendingJsonMapping: [String] = []
        
        // 輸出 struct 開頭
        let typeName = uppercaseedFirstChar(for: key)
        print("public struct \(typeName): \(JsonDeserializeable.self) {\r\n")
        
        let tabSapce = "    "
        
        for (key, value) in dictionary {
            
            switch value {
            case _ as String:
                print("\(tabSapce)public var \(key): String = \"\"")

                pendingJsonMapping.append("self.\(key) = parseString(value: jsonDictionary[\"\(key)\"])")
                
            case _ as Int:
                
                let defaultValue = -1
                print("\(tabSapce)public var \(key): Int = \(defaultValue)")
                pendingJsonMapping.append("self.\(key) = parseInt(value: jsonDictionary[\"\(key)\"], defaultValue: \(defaultValue))")
                
            case _ as Double:
                print("\(tabSapce)public var \(key): Double = 0.0")
                pendingJsonMapping.append("self.\(key) = parseDouble(value: jsonDictionary[\"\(key)\"])")
                
            case _ as [String]:
                print("\(tabSapce)public var \(key): [String] = []")
                pendingJsonMapping.append("self.\(key) = parseStringArray(value: jsonDictionary[\"\(key)\"])")
                
//            case _ as [Int]:
//                print("\(tabSapce)public var \(key): [Int] = []")
//                pendingJsonMapping.append("self.\(key) = parseInrArray(value: jsonDictionary[\"\(key)\"])")
//                
//            case _ as [Double]:
//                print("\(tabSapce)public var \(key): [Double] = []")
                
            case let value as JsonDictionary:
                
                let typeName = uppercaseedFirstChar(for: key)
                print("\(tabSapce)public var \(key): \(typeName) = \(typeName)()")
                
                pendingJsonDictionary.append((key, value))
                pendingJsonMapping.append("self.\(key) = \(typeName)(jsonDictionary: jsonDictionary[\"\(key)\"] as? JsonDictionary ?? JsonDictionary())")
                
                
            case let value as JsonArray:
                
                let typeName = uppercaseedFirstChar(for: key)
                print("\(tabSapce)public var \(key): [\(typeName)] = []")
                
                guard let value = value.first else {
                    continue
                }
                
                pendingJsonDictionary.append((key, value))
                pendingJsonMapping.append("self.\(key) = [\(typeName)](jsonArray: jsonDictionary[\"\(key)\"] as? JsonArray ?? JsonArray())")
                
            default:
                print("...無法剖析 key: \(key), value: \(value)")
            }
        }
        
        // 輸出 JsonDeserializeable 實作
        print()
        print("\(tabSapce)public init()")
        print("\(tabSapce){")
        print("\(tabSapce)")
        print("\(tabSapce)}")
        print("\(tabSapce)")
        print("\(tabSapce)public mutating func jsonMapping(_ jsonDictionary: JsonDictionary)")
        print("\(tabSapce){")
        
        for item in pendingJsonMapping {
            print("\(tabSapce)\(tabSapce)\(item)")
        }
            
        print("\(tabSapce)}")
        
        // 輸出 struct 後大刮號
        print("}\r\n")
        
        for (key, dictionary) in pendingJsonDictionary {
            convertToModel(for: dictionary, withKey: key)
        }
    }
    
    /// 首字轉大寫
    ///
    /// - Parameter str: 字串
    /// - Returns: 回傳首字轉大寫後字串
    private func uppercaseedFirstChar(for str: String) -> String
    {
        guard let firstChar = str.characters.first else {
            return ""
        }
        
        // struct name 首字大寫
        let firstCharUppercased = String(firstChar).uppercased()
        let othersKeyChar = str.substring(from: str.index(str.startIndex, offsetBy: 1))
        
        return "\(firstCharUppercased)\(othersKeyChar)"
    }
}
