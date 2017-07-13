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
        let jsonString = "{\"metadata\":{\"status\":\"0000\",\"desc\":\"zh-tw-正確\"},\"data\":{\"products\":{\"id\":\"2173\",\"name\":\"【保證入園】東京迪士尼電子門票：一日券（迪士尼樂園海洋二選一）\",\"introduction\":\"KKday東京迪士尼門票，保證入園免排隊買票、不受入園管制限制！保證入園期間內，任選一天皆可入園。將電子票券列印下來，直接掃描 QRcode 入園，不需至售票窗口兌換票券；還可用QRcode抽園內設施快速通關(Fast Pass)！\",\"min_price\":\"2,011\",\"desc\":\"－ 行程特色 －\\n\\n．不用指定園區與入園日期，2018年2月28日前都保證入園！\\n．列印電子券直接掃描QRcode入園，不需至售票窗口兌換票券。\\n．使用同一個 QRcode 抽園區內設施快速通關(Fast Pass)\\n．現場加價日幣200元，即可在園區的購票窗口換購實體東京迪士尼門票做紀念！\\n\\n\\n\\n－ 使用說明 －\\n\\n• 使用對象：4歲至64歲，不限使用者國籍\\n• 保證入園兌換期限：2018.2.28\\n• 開放時間：開園時間不定，詳情請參考中文官網：http://info.tokyodisneyresort.jp/tc/calendar/\\n• 如何抵達：\\n1. 直達巴士－由東京站出發約35分鐘，由新宿站出發約50分鐘\\n2. JR－由東京站搭乘JR京葉線或JR武藏野線到舞浜\\n\\n\\n\\n－ 方案介紹 －\\n\\n• 票卷方案：\\n．成人票：18 歲到 64 歲\\n．孩童票：12 歲到 17 歲\\n．幼兒票：4 歲到 11 歲\\n• 年齡0-3歲免費入場，65歲以上敬老票請於迪士尼官網或是現場購買。\\n\\n\\n\\n－ 兌換方式 － \\n\\n• 收到電子票券後，請務必列印出紙本（黑白即可），現場憑紙本憑證直接掃描QRcode即可入園。\\n• 恕不接受以智慧型電子產品出示門票，若未印出電子票券，園區將拒絕旅客入場，旅客須自行承擔風險。\\n• 請您在正確的預訂日期與開放時間內使用憑證，否則視為無效。\\n\\n\\n\\n－ 重要資訊 －\\n\\n．訂購時選擇的日期與票券上所標示之日期為隨機標註，不影響實際入園日期。\\n．本票券恕不適用於園區的特別營業時間。（例如：跨年特別營業時間、企業包場特別營業時間等）\",\"confirm_hour\":0,\"instant_booking\":true,\"currency\":\"TWD\",\"location\":\"日本, 東京, 多個城市\",\"rating\":{\"rating_star\":5,\"total_count\":1835,\"first_rating\":null},\"banner\":{\"images\":[{\"author\":\"ナギ (nagi)\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034717_QInp9/jpg\",\"default_img\":true},{\"author\":\"Ari Helminen\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034626_MMyho/jpg\",\"default_img\":false},{\"author\":\"Ari Helminen\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034642_SCGdV/jpg\",\"default_img\":false},{\"author\":\"Raymond WC Chow\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034402_NGsMA/jpg\",\"default_img\":false},{\"author\":\"s.yume\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034639_9ddVg/jpg\",\"default_img\":false},{\"author\":\"ナギ (nagi)\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034636_UNLCA/jpg\",\"default_img\":false},{\"author\":\"dai-kon\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034645_8w91A/jpg\",\"default_img\":false},{\"author\":\"ナギ (nagi)\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034652_wEozD/jpg\",\"default_img\":false},{\"author\":\"ナギ (nagi)\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20150528034630_qZQvL/jpg\",\"default_img\":false},{\"author\":\"chauromano\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20160413030104_JpfEn/jpg\",\"default_img\":false},{\"author\":\"Kyla Duhamel\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20160413030109_Xd939/jpg\",\"default_img\":false},{\"author\":\"Robert Montgomery\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20160413030338_7wa77/jpg\",\"default_img\":false},{\"author\":\"Cory Denton\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20160413030717_2gJY2/jpg\",\"default_img\":false},{\"author\":\"othree\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20160506111546_cxeIr/jpg\",\"default_img\":false},{\"author\":\"\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20170203073938_2sXFH/png\",\"default_img\":false}],\"videos\":[{\"video_url\":\"https://www.youtube.com/embed/Rh1W9zJzyA8\"}]},\"time_required\":{\"days\":0,\"hours\":10},\"guide_langs\":[\"中文\",\"日本語\",\"English\"],\"schedules\":[{\"day\":1,\"details\":[{\"desc\":\"請務必將票券列印成紙本，未列印成紙本票券，園區有權拒絕旅客入場\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173/20170203073938_2sXFH/png\",\"time\":\"\"}]}],\"maps\":{\"airport\":[{\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_7140/20170704055819_IBRp3/png\",\"airport_name\":\"test1\",\"airport_code\":\"GMP\",\"terminal_no\":\"1\"},{\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_7140/20170704114648_ZiaGd/png\",\"airport_name\":\"123456\",\"airport_code\":\"ICN\",\"terminal_no\":\"1\"},{\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_7140/20170704060024_D0M9g/jpg\",\"airport_name\":\"test2\",\"airport_code\":\"ICN\",\"terminal_no\":\"2\"}],\"meeting_point\":{\"address\":\"Taipei City, Taiwan\",\"longitude\":121.56543,\"latitude\":25.032963,\"img\":{\"img_url\":\"\",\"desc\":null}},\"main_destinations\":{\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_2173_location/20170625135812_QFqVS/png\",\"destinations\":[{\"desc\":\"日本千葉縣浦安市舞浜1-1號\",\"longitude\":\"139.8845778\",\"latitude\":\"35.6355849\"},{\"desc\":\"Testaccio Romo RM Italio\",\"longitude\":\"12.475694\",\"latitude\":\"41.875952\"}]}},\"exchange_method\":[{\"business_hours\":[{\"from\":{\"hour\":1,\"minute\":10},\"to\":{\"hour\":2,\"minute\":15},\"weekdays\":[\"7\"]}],\"name\":\"EXCAHNGE\",\"address\":\"EXCAHNGE ADDRESs\",\"note\":\"rrrrrrrr\"}],\"cancel_policy\":{\"policy_type\":\"3\",\"cancel_period_setting\":[{\"day\":1,\"is_over\":false,\"fee_percent\":10},{\"day\":5,\"is_over\":false,\"fee_percent\":5},{\"day\":6,\"is_over\":true,\"fee_percent\":1}]},\"price_details\":{\"included\":[\"門票\"],\"not_included\":[\"尿尿費\"]},\"reminds\":[\"當參加人數未達最少成團人數之1人時，將於出發日前1日發出取消行程的電郵通知。\",\"若需於同一日內多次進出園區（限同一園區）時，請至出口處蓋再入園手章。\",\"再次入園時，請向入口處的服務人員出示手章與園區票券，即可於同日內再次進入園區。\",\"於園內領取快速通行券（FAST PASS）時，須使用本票券，請妥善保存。\",\"敬老票與生日護照請於迪士尼官網或是現場購買。\",\"票券上字樣僅表示「開票地」，不限使用者國籍。\",\"【關於更改手續費】\",\"超過保證入園兌換期限，意即預計於2018.03.01~03.28使用本票的旅客，請於園區售票口支付日幣200元/張變更為『日付指定券』後方可入園\",\"一日券可更改為二日券，須至園區售票窗口，支付憑證上價格與現場售價之差價與票券更改手續費日幣400元。\",\"預訂成功後立即確認，電子憑證將於2個小時內寄至訂單聯絡人信箱，請隨時留意並查收信件。\"],\"tkt_effective_period\":\"需要按照預訂日期及當天開放時間內使用，逾期失效。\",\"recommends\":{\"products\":[{\"id\":\"7505\",\"name\":\"【優惠】東京迪士尼電子門票：二日券（迪士尼樂園海洋任選）\",\"price\":\"3,605\",\"img_url\":\"https://img.kkday.com/image/get/w_800%2Cc_fit/s1.kkday.com/product_7505/20160422093501_kgMAL/jpg\",\"countries\":[{\"id\":\"A01-003\",\"name\":\"日本\",\"cities\":[{\"id\":\"A01-003-00001\",\"name\":\"東京\"},{\"id\":\"A01-003-00039\",\"name\":\"千葉\"}]}],\"rating_count\":171,\"rating_star\":5,\"instant_booking\":false,\"currency\":\"TWD\"},[{\"id\":\"10356\",\"prod_url\":\"https://www.kkday.com/zh-tw/product/10356\",\"img_url\":\"https://image.kkday.com/image/get/w_450%2Cc_fit/s1.kkday.com/product_10356/20161122103348_DwTzk/jpg\",\"prod_name\":\"【台場必去】大江戶溫泉物語實體門票（台灣 / 香港郵寄．自取）\",\"price\":464,\"countries\":[{\"id\":\"A01-003\",\"name\":\"日本\",\"cities\":[{\"id\":\"A01-003-00001\",\"name\":\"東京\"}]}],\"rating_count\":120,\"rating_star\":5,\"instant_booking\":false,\"currency\":\"TWD\"},{\"id\":\"7505\",\"prod_url\":\"https://www.kkday.com/zh-tw/product/7505\",\"img_url\":\"https://image.kkday.com/image/get/w_450%2Cc_fit/s1.kkday.com/product_7505/20160422093501_kgMAL/jpg\",\"prod_name\":\"【優惠】東京迪士尼電子門票：二日券（迪士尼樂園海洋任選）\",\"price\":3600,\"countries\":[{\"id\":\"A01-003\",\"name\":\"日本\",\"cities\":[{\"id\":\"A01-003-00001\",\"name\":\"東京\"}]}],\"rating_count\":171,\"rating_star\":5,\"instant_booking\":false,\"currency\":\"TWD\"},{\"id\":\"5989\",\"prod_url\":\"https://www.kkday.com/zh-tw/product/5989\",\"img_url\":\"https://image.kkday.com/image/get/w_450%2Cc_fit/s1.kkday.com/product_5989/20160129063011_Dtcb5/jpg\",\"prod_name\":\"【Tokyo Subway Ticket】東京地鐵乘車券 - 24小時/48小時/72小時券\",\"price\":242,\"countries\":[{\"id\":\"A01-003\",\"name\":\"日本\",\"cities\":[{\"id\":\"A01-003-00001\",\"name\":\"東京\"}]}],\"rating_count\":119,\"rating_star\":5,\"instant_booking\":false,\"currency\":\"TWD\"},{\"id\":\"10074\",\"prod_url\":\"https://www.kkday.com/zh-tw/product/10074\",\"img_url\":\"https://image.kkday.com/image/get/w_450%2Cc_fit/s1.kkday.com/product_10074/20161124041056_P1otx/jpg\",\"prod_name\":\"【東京必去】藤子F不二雄博物館門票・日本國內郵寄（含門票1000日幣＋郵寄費手續費）\",\"price\":409,\"countries\":[{\"id\":\"A01-003\",\"name\":\"日本\",\"cities\":[{\"id\":\"A01-003-00001\",\"name\":\"東京\"}]}],\"rating_count\":11,\"rating_star\":5,\"instant_booking\":false,\"currency\":\"TWD\"},{\"id\":\"11938\",\"prod_url\":\"https://www.kkday.com/zh-tw/product/11938\",\"img_url\":\"https://image.kkday.com/image/get/w_450%2Cc_fit/s1.kkday.com/product_11938/20170509035626_wAZaJ/jpg\",\"prod_name\":\"【東京巴士一日遊】河口湖薰衣草節・富士山五合目・採桃子吃到飽\",\"price\":3539,\"countries\":[{\"id\":\"A01-003\",\"name\":\"日本\",\"cities\":[{\"id\":\"A01-003-00001\",\"name\":\"東京\"}]}],\"rating_count\":0,\"rating_star\":0,\"instant_booking\":false,\"currency\":\"TWD\"}]]}}}}"
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
        var pendingInit: [(key: String, type: String)] = []
        var pendingJsonMapping: [String] = []
        
        // 輸出 struct 開頭
        let typeName = uppercaseedFirstChar(for: key)
        print("public struct \(typeName): \(JsonDeserializeable.self) {\r\n")
        
        let tabSapce = "    "
        
        for (key, value) in dictionary {
            
            switch value {
            case _ as String:
                print("\(tabSapce)public var \(key): String = \"\"")

                pendingInit.append((key: key, type: "String"))
                
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].stringOrDefault")
                
            case _ as Int:
                
                let defaultValue = -1
                print("\(tabSapce)public var \(key): Int = \(defaultValue)")
                
                pendingInit.append((key: key, type: "Int"))
                
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].intOrDefault")
                
            case _ as Bool:
                print("\(tabSapce)public var \(key): Bool = false")
                
                pendingInit.append((key: key, type: "Bool"))
                
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].boolOrDefault")
                
            case _ as Double:
                print("\(tabSapce)public var \(key): Double = 0.0")
                
                pendingInit.append((key: key, type: "Double"))
                
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].doubleOrDefault")
                
            case _ as [String]:
                print("\(tabSapce)public var \(key): [String] = []")
                
                pendingInit.append((key: key, type: "[String]"))
                
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].stringArrayOrDefault")
                
            case _ as [Int]:
                print("\(tabSapce)public var \(key): [Int] = []")
                
                pendingInit.append((key: key, type: "[Int]"))
                
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].intArrayOrDefault")
                
            case _ as [Double]:
                print("\(tabSapce)public var \(key): [Double] = []")
                
                pendingInit.append((key: key, type: "[Double]"))
                
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].doubleArrayOrDefault")
                
            case let value as JsonDictionary:
                
                let typeName = uppercaseedFirstChar(for: key)
                print("\(tabSapce)public var \(key): \(typeName) = \(typeName)()")
                
                pendingInit.append((key: key, type: "\(typeName)"))
                
                pendingJsonDictionary.append((key, value))
                pendingJsonMapping.append("self.\(key) = \(typeName)(jsonDictionary: jsonDictionary[\"\(key)\"].jsonDictionaryOrDefault)")
                
                
            case let value as JsonArray:
                
                let typeName = uppercaseedFirstChar(for: key)
                print("\(tabSapce)public var \(key): [\(typeName)] = []")
                
                pendingInit.append((key: key, type: "[\(typeName)]"))
                
                guard let value = value.first else {
                    continue
                }
                
                pendingJsonDictionary.append((key, value))
                pendingJsonMapping.append("self.\(key) = [\(typeName)](jsonArray: jsonDictionary[\"\(key)\"].jsonArrayOrDefault)")
                
            default:
                print("...無法剖析 \(tabSapce)public var \(key): String = \"\"")
                
                pendingInit.append((key: key, type: "String ...無法剖析"))
                
                pendingJsonMapping.append("...無法剖析 self.\(key) = jsonDictionary[\"\(key)\"].stringOrDefault")
            }
        }
        
        // 輸出 JsonDeserializeable 實作
        print()
        print("\(tabSapce)public init()")
        print("\(tabSapce){")
        print("\(tabSapce)")
        print("\(tabSapce)}")
        
        print("\(tabSapce)")
        
        print("\(tabSapce)public init(\(pendingInit.map { "\($0.key): \($0.type)" }.joined(separator: ", ")))")
        print("\(tabSapce){")
        
        for item in pendingInit {
            print("\(tabSapce)\(tabSapce)self.\(item.key) = \(item.key)")
        }
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
