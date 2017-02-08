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
        
    }
    
    @IBAction func printJsonModel(_ sender: UIButton) {
        printJsonModel()
    }
    
    @IBAction func printJsonString(_ sender: UIButton) {
        printJsonString()
    }
    
    @IBAction func printJsonArray(_ sender: UIButton) {
        printJsonArray()
    }
    
    @IBAction func printNativeJsonArray(_ sender: UIButton) {
        printNativeJsonArray()
    }
}

extension ViewController {

    fileprivate func printJsonString() {
        
        let skills = (1...10).map { Model.Skill(name: String($0)) }
        let model = Model(skill: skills, other: Model.Other(info: "other info"))
        let json = model.toJsonString(.prettyPrinted)
        
        print("\r\n\r\n")
        print("Json: \(json)")
        print("\r\n\r\n")
        print("Model: \(model)")
    }
    
    fileprivate func printJsonArray() {
        
        let skills = (1...10).map { Model.Skill(name: String($0)) }
        let model = Model(skill: skills, other: Model.Other(info: "other info"))
        let json = model.skill.toJsonString(.prettyPrinted)
        
        print("\r\n\r\n")
        print("Json: \(json)")
        print("\r\n\r\n")
        print("Model: \(model)")
    }
    
    fileprivate func printNativeJsonArray() {
        let skills = (1...10).map { Model.Skill(name: String($0)) }
        let native = (1...10).map { String($0) }
        let model = Model(skill: skills, native: native)
        let json = model.native?.toJsonString(.prettyPrinted) ?? "[]"
        
        print("\r\n\r\n")
        print("Json: \(json)")
        print("\r\n\r\n")
        print("Model: \(model)")
    }
    
    fileprivate func printJsonModel()
    {
        let jsonString = "{\"list\":[{\"header\":1,\"content\":[{\"code\":1,\"name\":\"美國\"},{\"code\":1,\"name\":\"加拿大\"},{\"code\":1,\"name\":\"安圭拉\"},{\"code\":1,\"name\":\"安地卡及巴布達\"},{\"code\":1,\"name\":\"巴貝多\"},{\"code\":1,\"name\":\"巴哈馬\"},{\"code\":1,\"name\":\"百慕達\"},{\"code\":1,\"name\":\"英屬維京群島\"},{\"code\":1,\"name\":\"開曼群島\"},{\"code\":1,\"name\":\"多米尼克\"},{\"code\":1,\"name\":\"多明尼加\"},{\"code\":1,\"name\":\"格瑞那達\"},{\"code\":1,\"name\":\"牙買加\"},{\"code\":1,\"name\":\"蒙哲臘\"},{\"code\":1,\"name\":\"荷屬聖馬丁\"},{\"code\":1,\"name\":\"波多黎各\"},{\"code\":1,\"name\":\"聖克里斯多福與尼維斯\"},{\"code\":1,\"name\":\"聖露西亞\"},{\"code\":1,\"name\":\"聖文森及格瑞那丁\"},{\"code\":1,\"name\":\"千里達及托巴哥\"},{\"code\":1,\"name\":\"特克斯與凱科斯群島\"},{\"code\":1,\"name\":\"關島\"},{\"code\":1,\"name\":\"北馬利亞納群島\"},{\"code\":1,\"name\":\"美屬薩摩亞\"}]},{\"header\":2,\"content\":[{\"code\":20,\"name\":\"埃及\"},{\"code\":210,\"name\":\"阿拉伯聯合大公國\"},{\"code\":211,\"name\":\"南蘇丹\"},{\"code\":212,\"name\":\"摩洛哥\"},{\"code\":213,\"name\":\"阿爾及利亞\"},{\"code\":216,\"name\":\"突尼西亞\"},{\"code\":218,\"name\":\"利比亞\"},{\"code\":220,\"name\":\"甘比亞\"},{\"code\":221,\"name\":\"塞內加爾\"},{\"code\":222,\"name\":\"茅利塔尼亞\"},{\"code\":223,\"name\":\"馬利\"},{\"code\":224,\"name\":\"幾內亞\"},{\"code\":225,\"name\":\"象牙海岸\"},{\"code\":226,\"name\":\"布吉納法索\"},{\"code\":227,\"name\":\"尼日\"},{\"code\":228,\"name\":\"多哥\"},{\"code\":229,\"name\":\"貝南\"},{\"code\":230,\"name\":\"模里西斯\"},{\"code\":231,\"name\":\"賴比瑞亞\"},{\"code\":232,\"name\":\"獅子山\"},{\"code\":233,\"name\":\"加納\"},{\"code\":234,\"name\":\"奈及利亞\"},{\"code\":235,\"name\":\"查德\"},{\"code\":236,\"name\":\"中非\"},{\"code\":237,\"name\":\"喀麥隆\"},{\"code\":238,\"name\":\"維德角\"},{\"code\":239,\"name\":\"聖多美普林西比\"},{\"code\":240,\"name\":\"赤道幾內亞\"},{\"code\":241,\"name\":\"加彭\"},{\"code\":242,\"name\":\"剛果共和國\"},{\"code\":243,\"name\":\"剛果民主共和國\"},{\"code\":244,\"name\":\"安哥拉\"},{\"code\":245,\"name\":\"幾內亞比索\"},{\"code\":246,\"name\":\"迪戈加西亞島\"},{\"code\":247,\"name\":\"阿森松島\"},{\"code\":248,\"name\":\"塞席爾\"},{\"code\":249,\"name\":\"蘇丹\"},{\"code\":250,\"name\":\"盧安達\"},{\"code\":251,\"name\":\"衣索比亞\"},{\"code\":252,\"name\":\"索馬利亞\"},{\"code\":253,\"name\":\"吉布地\"},{\"code\":254,\"name\":\"肯亞\"},{\"code\":255,\"name\":\"坦尚尼亞\"},{\"code\":256,\"name\":\"烏干達\"},{\"code\":257,\"name\":\"蒲隆地\"},{\"code\":258,\"name\":\"莫三比克\"},{\"code\":260,\"name\":\"尚比亞\"},{\"code\":261,\"name\":\"馬達加斯加\"},{\"code\":262,\"name\":\"留尼旺和馬約特\"},{\"code\":263,\"name\":\"辛巴威\"},{\"code\":264,\"name\":\"納米比亞\"},{\"code\":265,\"name\":\"馬拉威\"},{\"code\":266,\"name\":\"賴索托\"},{\"code\":267,\"name\":\"波札那\"},{\"code\":268,\"name\":\"史瓦濟蘭\"},{\"code\":269,\"name\":\"葛摩\"},{\"code\":27,\"name\":\"南非\"},{\"code\":290,\"name\":\"聖赫勒拿\"},{\"code\":291,\"name\":\"厄利垂亞\"},{\"code\":291,\"name\":\"厄利垂亞\"},{\"code\":297,\"name\":\"阿魯巴\"},{\"code\":298,\"name\":\"法羅群島法羅群島\"},{\"code\":299,\"name\":\"格陵蘭\"}]},{\"header\":3,\"content\":[{\"code\":30,\"name\":\"希臘\"},{\"code\":31,\"name\":\"荷蘭\"},{\"code\":32,\"name\":\"比利時\"},{\"code\":33,\"name\":\"法國\"},{\"code\":34,\"name\":\"西班牙\"},{\"code\":350,\"name\":\"直布羅陀\"},{\"code\":351,\"name\":\"葡萄牙\"},{\"code\":352,\"name\":\"盧森堡\"},{\"code\":353,\"name\":\"愛爾蘭\"},{\"code\":354,\"name\":\"冰島\"},{\"code\":355,\"name\":\"阿爾巴尼亞\"},{\"code\":356,\"name\":\"馬爾地\"},{\"code\":357,\"name\":\"賽普勒斯\"},{\"code\":358,\"name\":\"芬蘭\"},{\"code\":358,\"name\":\"奧蘭\"},{\"code\":359,\"name\":\"保加利亞\"},{\"code\":36,\"name\":\"匈牙利\"},{\"code\":370,\"name\":\"立討晚\"},{\"code\":371,\"name\":\"拉脫維亞\"},{\"code\":372,\"name\":\"愛沙尼亞\"},{\"code\":373,\"name\":\"摩爾多瓦\"},{\"code\":374,\"name\":\"亞美尼亞\"},{\"code\":375,\"name\":\"白俄羅斯\"},{\"code\":376,\"name\":\"安道爾\"},{\"code\":377,\"name\":\"摩納哥\"},{\"code\":378,\"name\":\"聖馬利諾\"},{\"code\":379,\"name\":\"梵蒂岡\"},{\"code\":380,\"name\":\"烏克蘭\"},{\"code\":381,\"name\":\"塞爾維亞\"},{\"code\":382,\"name\":\"蒙特內哥羅\"},{\"code\":384,\"name\":\"科索沃\"},{\"code\":385,\"name\":\"克羅埃西亞\"},{\"code\":386,\"name\":\"斯洛維尼亞\"},{\"code\":387,\"name\":\"波士尼亞與赫塞哥維納\"},{\"code\":389,\"name\":\"馬其頓\"},{\"code\":39,\"name\":\"義大利\"}]},{\"header\":4,\"content\":[{\"code\":40,\"name\":\"羅馬尼亞\"},{\"code\":41,\"name\":\"瑞士\"},{\"code\":420,\"name\":\"捷克\"},{\"code\":421,\"name\":\"斯洛伐克\"},{\"code\":423,\"name\":\"列支敦斯登\"},{\"code\":43,\"name\":\"奧地利\"},{\"code\":44,\"name\":\"英國\"},{\"code\":45,\"name\":\"丹麥\"},{\"code\":46,\"name\":\"瑞典\"},{\"code\":47,\"name\":\"挪威\"},{\"code\":48,\"name\":\"波蘭\"},{\"code\":49,\"name\":\"德國\"}]},{\"header\":5,\"content\":[{\"code\":500,\"name\":\"福克蘭群島\"},{\"code\":501,\"name\":\"貝里斯\"},{\"code\":502,\"name\":\"瓜地馬拉\"},{\"code\":503,\"name\":\"薩爾瓦多\"},{\"code\":504,\"name\":\"宏都拉斯\"},{\"code\":505,\"name\":\"尼加拉瓜\"},{\"code\":506,\"name\":\"哥斯大黎加\"},{\"code\":507,\"name\":\"巴拿馬\"},{\"code\":508,\"name\":\"聖皮耶與密克隆\"},{\"code\":509,\"name\":\"海地\"},{\"code\":51,\"name\":\"秘魯\"},{\"code\":52,\"name\":\"墨西哥\"},{\"code\":53,\"name\":\"古巴\"},{\"code\":54,\"name\":\"阿根廷\"},{\"code\":55,\"name\":\"巴西\"},{\"code\":56,\"name\":\"智利\"},{\"code\":57,\"name\":\"哥倫比亞\"},{\"code\":58,\"name\":\"委內瑞拉\"},{\"code\":590,\"name\":\"瓜德羅普\"},{\"code\":591,\"name\":\"玻利維亞\"},{\"code\":592,\"name\":\"蓋亞那\"},{\"code\":593,\"name\":\"厄瓜多\"},{\"code\":594,\"name\":\"法屬圭亞那\"},{\"code\":595,\"name\":\"巴拉圭\"},{\"code\":596,\"name\":\"馬提尼克\"},{\"code\":597,\"name\":\"蘇利南\"},{\"code\":598,\"name\":\"烏拉圭\"},{\"code\":599,\"name\":\"荷屬安的列斯\"}]},{\"header\":6,\"content\":[{\"code\":60,\"name\":\"馬來西亞\"},{\"code\":61,\"name\":\"澳洲\"},{\"code\":62,\"name\":\"印尼\"},{\"code\":63,\"name\":\"菲律賓\"},{\"code\":64,\"name\":\"紐西蘭\"},{\"code\":65,\"name\":\"新加坡\"},{\"code\":66,\"name\":\"泰國\"},{\"code\":670,\"name\":\"東帝汶\"},{\"code\":673,\"name\":\"汶萊\"},{\"code\":674,\"name\":\"諾魯\"},{\"code\":675,\"name\":\"巴布亞紐幾內亞\"},{\"code\":676,\"name\":\"東加\"},{\"code\":677,\"name\":\"索羅門群島\"},{\"code\":678,\"name\":\"萬那杜\"},{\"code\":679,\"name\":\"斐濟\"},{\"code\":680,\"name\":\"帛琉\"},{\"code\":681,\"name\":\"瓦利斯和富圖納\"},{\"code\":682,\"name\":\"庫克群島\"},{\"code\":683,\"name\":\"紐埃\"},{\"code\":685,\"name\":\"薩摩亞\"},{\"code\":686,\"name\":\"吉里巴斯\"},{\"code\":687,\"name\":\"新喀里多尼亞\"},{\"code\":688,\"name\":\"吐瓦魯\"},{\"code\":689,\"name\":\"法屬玻里尼西亞\"},{\"code\":690,\"name\":\"托克勞\"},{\"code\":691,\"name\":\"密克羅尼西亞聯邦\"},{\"code\":692,\"name\":\"馬紹爾群島\"}]},{\"header\":7,\"content\":[{\"code\":7,\"name\":\"俄羅斯\"},{\"code\":77,\"name\":\"哈薩克\"}]},{\"header\":8,\"content\":[{\"code\":81,\"name\":\"日本\"},{\"code\":82,\"name\":\"南韓\"},{\"code\":84,\"name\":\"越南\"},{\"code\":850,\"name\":\"北韓\"},{\"code\":852,\"name\":\"香港\"},{\"code\":853,\"name\":\"澳門\"},{\"code\":855,\"name\":\"柬埔寨\"},{\"code\":856,\"name\":\"寮國\"},{\"code\":86,\"name\":\"中華人民共和國\"},{\"code\":880,\"name\":\"孟加拉\"},{\"code\":886,\"name\":\"台灣\"}]},{\"header\":9,\"content\":[{\"code\":90,\"name\":\"土耳其\"},{\"code\":91,\"name\":\"印度\"},{\"code\":92,\"name\":\"巴基斯坦\"},{\"code\":93,\"name\":\"阿富汗\"},{\"code\":94,\"name\":\"斯里蘭卡\"},{\"code\":95,\"name\":\"緬甸\"},{\"code\":960,\"name\":\"馬爾地夫\"},{\"code\":961,\"name\":\"黎巴嫩\"},{\"code\":962,\"name\":\"約旦\"},{\"code\":963,\"name\":\"敘利亞\"},{\"code\":964,\"name\":\"伊拉克\"},{\"code\":965,\"name\":\"科威特\"},{\"code\":966,\"name\":\"沙烏地阿拉伯\"},{\"code\":967,\"name\":\"葉門\"},{\"code\":968,\"name\":\"阿曼\"},{\"code\":970,\"name\":\"巴勒斯坦\"},{\"code\":971,\"name\":\"阿聯\"},{\"code\":972,\"name\":\"以色列\"},{\"code\":973,\"name\":\"巴林\"},{\"code\":974,\"name\":\"卡達\"},{\"code\":975,\"name\":\"不丹\"},{\"code\":976,\"name\":\"蒙古\"},{\"code\":977,\"name\":\"尼泊爾\"},{\"code\":98,\"name\":\"伊朗\"},{\"code\":992,\"name\":\"塔吉克\"},{\"code\":993,\"name\":\"土庫曼\"},{\"code\":994,\"name\":\"亞塞拜然\"},{\"code\":995,\"name\":\"喬治亞共和國\"},{\"code\":996,\"name\":\"吉爾吉斯\"},{\"code\":998,\"name\":\"烏茲別克\"}]}]}"
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
