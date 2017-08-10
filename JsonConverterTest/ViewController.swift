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
        let jsonString = "{\"metadata\":{\"status\":\"0000\",\"desc\":\"正確\"},\"data\":{\"summary\":{\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_1875/20161215093757_dGISO/png\",\"order_date\":1500452760000,\"prod_name\":\"【出海吧！與鯨豚奇遇】花蓮賞鯨游船體驗（免費接送）\",\"begin_go_date\":\"2017-07-28 (台北)\",\"pkg_name\":\"賞鯨體驗\",\"has_event\":true,\"event_time\":\"14:00\",\"guide_lang\":\"zh-tw\",\"cancellation\":{\"cancel_date\":\"2017-08-03 12:39 (首爾)\",\"price_pay\":69.69,\"cancel_fee\":0,\"refund_status\":false,\"price_refund\":0},\"price_detail\":[{\"id\":\"price1\",\"display_price\":\"267.88\",\"currency\":\"USD\",\"unit_txt\":\"輛\",\"quanity\":1}],\"display_price\":\"267.88\",\"display_price_coupon\":\"0\",\"display_price_total\":\"267.88\",\"purchase_info\":{\"customer\":{\"first_name\":\"軒領\",\"last_name\":\"許\",\"country_cd\":\"台灣\",\"create_date\":\"2017-07-19 13:38 (首爾)\",\"email\":\"sean.hsu@kkday.com\",\"tel_country_cd\":\"886\",\"tel_number\":\"1234567\"},\"asia_mile\":{\"number\":\"1558346027\",\"first_name\":\"CHEN\",\"last_name\":\"HUANG\"}},\"event_backup\":[{\"id\":\"1\",\"text\":\"第一候補場次\",\"date\":\"2017-07-27\",\"time\":\"11:00\"}],\"flight_info\":{\"arrival\":{\"flight_type\":\"02\",\"airport\":\"ICN\",\"airline\":\"CATHAY\",\"flight_no\":\"CX462\",\"terminal_no\":\"T1\",\"is_need_to_apply_visa\":true,\"arrival_datetime\":{\"date\":\"2017-07-20\",\"hour\":4,\"minute\":3}},\"departure\":{\"flight_type\":null,\"airport\":null,\"terminal_no\":null,\"airline\":null,\"flight_no\":null,\"departure_datetime\":{\"date\":null,\"hour\":null,\"minute\":null},\"have_been_in_country\":null}},\"shuttle_info\":{\"shuttle_date\":\"2017-07-28\",\"designated_by_customer\":{\"pick_up\":{\"location\":\"上車地點\",\"time\":{\"is_custom\":null,\"time_id\":null,\"hour\":null,\"minute\":null}},\"drop_off\":{\"location\":\"下車地點\"}},\"designated_location\":{\"location_id\":null},\"charter_route\":{\"is_custom\":null,\"routes_id\":null,\"custom_routes\":null}},\"car_rental_info\":{\"pick_up\":{\"office_id\":\"20170719_w495u\",\"datetime\":{\"date\":\"2017-07-25\",\"hour\":4,\"minute\":40},\"order_prod_setting\":{\"id\":\"20170719_w495u\",\"area_code\":\"A06-001-00001\",\"office_name\":\"澳客營\",\"address_eng\":\"hihi how r u\",\"address_local\":\"hihi how r u\",\"business_hours\":{\"from\":{\"hour\":2,\"minute\":0},\"to\":{\"hour\":8,\"minute\":0}},\"sort\":0,\"drop_off_interval\":10}},\"drop_off\":{\"office_id\":\"20170719_w495u\",\"datetime\":{\"date\":\"2017-07-31\",\"hour\":3,\"minute\":20},\"order_prod_setting\":{\"id\":\"20170719_w495u\",\"area_code\":\"A06-001-00001\",\"office_name\":\"澳客營\",\"address_eng\":\"hihi how r u\",\"address_local\":\"hihi how r u\",\"business_hours\":{\"from\":{\"hour\":2,\"minute\":0},\"to\":{\"hour\":8,\"minute\":0}},\"sort\":0,\"drop_off_interval\":10}},\"is_need_free_wi_fi\":null,\"is_need_free_gps\":null},\"psgr_info\":{\"qty_adult\":3,\"qty_infant\":1,\"qty_safety_seat\":{\"child_seat\":{\"supplier_provided\":1,\"self_provided\":1},\"infant_seat\":{\"supplier_provided\":0,\"self_provided\":1}},\"qty_carry_luggage\":2,\"qty_checked_luggage\":1,\"qty_child\":null},\"mailing_info\":{\"receiver_name\":{\"first_name\":\"MIKE\",\"last_name\":\"CHEN\"},\"receiver_tel\":{\"tel_country_code\":\"886\",\"tel_number\":\"1234567\"},\"send_to_country\":{\"receive_address\":{\"country_code\":\"台灣\",\"city_code\":\"平溪\",\"zip_code\":\"100\",\"address\":\"平溪天燈讚啦就在我家\"}},\"send_to_hotel\":{\"hotel_name\":\"SUPER HOTEL\",\"hotel_address\":\"1073 Saginaw Ter, unit 102\",\"hotel_tel\":\"0204000000\",\"booking_order_no\":\"00024\",\"booking_website\":\"agoda\",\"check_in_date\":\"2017-07-28\",\"check_out_date\":\"2017-07-29\",\"buyer_passport_english_name\":{\"first_name\":\"CHEN\",\"last_name\":\"HUANG\"},\"buyer_local_name\":{\"first_name\":\"閔煌\",\"last_name\":\"陳\"}},\"booking_order_no\":null,\"booking_website\":null,\"check_in_date\":null,\"check_out_date\":null},\"ship_info\":{\"ship_date\":null,\"tracking_number\":null}},\"cust_info\":[{\"english_name\":{\"first_name\":\"CHEN\",\"last_name\":\"HUANG\"},\"gender\":\"M\",\"nationality\":{\"nationality_code\":\"AI\",\"tw_identity_number\":null,\"hkmo_identity_number\":null,\"mtp_number\":null},\"birthday\":\"1904-06-06\",\"passport\":{\"passport_no\":\"308324657\",\"passport_exp_date\":\"2023-05-09\"},\"local_name\":{\"first_name\":\"CHEN\",\"last_name\":\"HUANG\"},\"height\":{\"unit\":\"01\",\"value\":182},\"weight\":{\"unit\":\"01\",\"value\":111},\"shoe_size\":{\"type\":\"M\",\"unit\":\"01\",\"value\":8.5},\"meal\":{\"meal_type\":{\"type\":\"0001\",\"type_name\":\"葷\"},\"exclude_food_type\":[{\"type\":\"0004\",\"type_name\":\"羊\"}],\"food_allergy\":{\"is_food_allergy\":null,\"allergen_list\":null}},\"glass_diopter\":500}],\"contact_info\":{\"contact_tel\":{\"have_tel\":true,\"tel_country_code\":\"886\",\"tel_number\":\"0919130681\"},\"contact_app\":{\"have_app\":true,\"app_type\":{\"type\":\"0001\",\"type_name\":\"Line\"},\"app_account\":\"dirose\"},\"contact_name\":{\"first_name\":null,\"last_name\":null}},\"other_info\":{\"mobile_model_number\":\"手機的型號\",\"mobile_imei\":\"111111111111111\",\"activation_date\":\"2017-07-25\",\"exchange_location_id\":null},\"order_note\":\"備註事項\"},\"product\":{\"prod_desc\":\"－ 行程特色 －\\n\\n．近距離感受海豚在海上激情跳躍\\n．有機會遇見百隻海豚大軍與其他海洋生物ex:抹香鯨、魟魚\\n．行程未見任何鯨豚將贈送記名船票，不限使用日期，皆可再來觀賞\\n\\n\\n－行程資訊－\\n\\n．航班時間：08:30、10:30、14:00（七、八月加開06:30 & 16:00）\\n．報到地點：花蓮市民權路37號\\n．行程長度：全程約2至3小時 (依當時海況做適度調整）\\n．兌換方式：出示確認憑證及個人證件\\n\\n\\n\\n－重要資訊－\\n\\n．開船時刻前30分鐘準時至指定集合地點\\n．接送時間需按照預定航班提前1小時在指定地點等待接駁\\n．接送區域：花蓮市區飯店/民宿\\n\\n\\n\\n－ 行程介紹 －\\n\\n每年4月至10月為賞鯨豚的黃金時期，花蓮海域擁有抹香鯨、啄鯨、費氏海豚、花紋海豚、飛旋海豚等20多種鯨豚，出海尋獲率高達95%。快跟隨海豚，享受乘風破浪的快感，這是漁人專屬的權利，此時此刻，您也可以親身感受。\",\"schedules\":[{\"day\":1,\"details\":[{\"desc\":\"提供花蓮市區免費接駁\",\"img_url\":\"\",\"time\":\"\"},{\"desc\":\"集合地點報到\",\"img_url\":\"\",\"time\":\"\"},{\"desc\":\"出海賞鯨囉！\",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_1875/20161215093804_XocsN/png\",\"time\":\"\"},{\"desc\":\"哈囉海豚 \",\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_1875/20161215093755_7rGjr/png\",\"time\":\"\"},{\"desc\":\"返回花蓮市區\",\"img_url\":\"\",\"time\":\"\"}],\"fee_included\":null}],\"maps\":{\"airport\":[{\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_10835/20170123080121_pBP9t/jpg\",\"airport_name\":\"仁川機場 4號出口旁櫃檯，8號出口旁櫃檯\",\"airport_code\":\"ICN\",\"terminal_no\":\"1\"}],\"meeting_point\":{\"address\":\"釜山西面站\",\"latitude\":35.157696,\"longitude\":129.05872,\"img\":{\"url\":null,\"desc\":null}},\"main_destinations\":{\"img_url\":\"https://img.kkday.com/image/get/s1.kkday.com/product_1875_location/20161215094148_QpBMr/png\",\"destinations\":[{\"desc\":\"花蓮市民權路37號\",\"longitude\":\"121.6219949\",\"latitude\":\"23.9837488\",\"latlong_type\":\"ARR\"}]}},\"reminds\":[\"若遇颱風、暴風雪等天候不佳的情況，將於出發前1日的20:00決定此團是否取消，之後以電郵形式通知。\",\"坐船出海需要提供基本資料進行報關(海巡署)及辦保險之用，請攜帶身份證件。\",\"客服人員會於出航前一天傍晚主動聯絡並提醒當天報到的時間，請保持聯絡方式暢通，以方便客服電話聯繫搭船事宜。\",\"請預先做好防曬措施：太陽眼鏡、防曬油、遮陽帽、薄的長袖外套(襯衫)\"],\"policy_list\":[{\"policy\":{\"beg_date\":\"2017-07-26\",\"end_date\":\"2017-08-02\",\"percent\":10}},{\"policy\":{\"beg_date\":\"2017-08-03\",\"end_date\":\"2017-08-09\",\"percent\":20}},{\"policy\":{\"beg_date\":\"2017-08-10\",\"end_date\":\"2017-08-15\",\"percent\":30}},{\"policy\":{\"beg_date\":\"2017-08-16\",\"end_date\":\"2017-08-16\",\"percent\":50}},{\"policy\":{\"beg_date\":\"2017-08-17\",\"end_date\":\"2017-08-17\",\"percent\":100}}]}}"
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
        let typeName = pascalCase(for: key)
        print("public struct \(typeName): \(JsonDeserializeable.self) {\r\n")
        
        let tabSapce = "    "
        
        for (key, value) in dictionary {

            let swiftProperty = camelCase(for: key)
            let jsonKey = key
            
            switch value {
            case _ as String:
                print("\(tabSapce)public var \(swiftProperty): String = \"\"")

                pendingInit.append((key: swiftProperty, type: "String"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringOrDefault")
                
            case _ as Int:
                
                let defaultValue = -1
                print("\(tabSapce)public var \(swiftProperty): Int = \(defaultValue)")
                
                pendingInit.append((key: swiftProperty, type: "Int"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intOrDefault")
                
            case _ as Bool:
                print("\(tabSapce)public var \(swiftProperty): Bool = false")
                
                pendingInit.append((key: swiftProperty, type: "Bool"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].boolOrDefault")
                
            case _ as Double:
                print("\(tabSapce)public var \(swiftProperty): Double = 0.0")
                
                pendingInit.append((key: swiftProperty, type: "Double"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleOrDefault")
                
            case _ as [String]:
                print("\(tabSapce)public var \(swiftProperty): [String] = []")
                
                pendingInit.append((key: swiftProperty, type: "[String]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].stringArrayOrDefault")
                
            case _ as [Int]:
                print("\(tabSapce)public var \(swiftProperty): [Int] = []")
                
                pendingInit.append((key: swiftProperty, type: "[Int]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].intArrayOrDefault")
                
            case _ as [Double]:
                print("\(tabSapce)public var \(swiftProperty): [Double] = []")
                
                pendingInit.append((key: swiftProperty, type: "[Double]"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"].doubleArrayOrDefault")
                
            case let value as JsonDictionary:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                print("\(tabSapce)public var \(swiftProperty): \(typeName) = \(typeName)()")
                
                pendingInit.append((key: swiftProperty, type: "\(typeName)"))
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = \(typeName)(jsonDictionary: jsonDictionary[\"\(jsonKey)\"].jsonDictionaryOrDefault)")
                
                
            case let value as JsonArray:
                
                let typeName = uppercaseedFirstChar(for: swiftProperty)
                print("\(tabSapce)public var \(swiftProperty): [\(typeName)] = []")
                
                pendingInit.append((key: swiftProperty, type: "[\(typeName)]"))
                
                guard let value = value.first else {
                    continue
                }
                
                pendingJsonDictionary.append((jsonKey, value))
                pendingJsonMapping.append("self.\(swiftProperty) = [\(typeName)](jsonArray: jsonDictionary[\"\(jsonKey)\"].jsonArrayOrDefault)")
                
            default:
                print("\(tabSapce)public var \(swiftProperty): Any? = nil")
                
                pendingInit.append((key: typeName, type: "Any?"))
                
                pendingJsonMapping.append("self.\(swiftProperty) = jsonDictionary[\"\(jsonKey)\"]")
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
    private func uppercaseedFirstChar(for str: String?) -> String
    {
        guard let str = str else {
            return ""
        }
        
        guard let firstChar = str.characters.first else {
            return ""
        }
        
        // struct name 首字大寫
        let firstCharUppercased = String(firstChar).uppercased()
        let othersKeyChar = str.substring(from: str.index(str.startIndex, offsetBy: 1))
        
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
        
        guard let firstChar = str.characters.first else {
            return ""
        }
        
        // struct name 首字小寫
        let firstCharLowercased = String(firstChar).lowercased()
        let othersKeyChar = str.substring(from: str.index(str.startIndex, offsetBy: 1))
        
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
        var otherStringArray = stringArray.dropFirst().map { $0.characters.count > 3 ? uppercaseedFirstChar(for: $0) : $0.uppercased() }
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
        var otherStringArray = stringArray.dropFirst().map { $0.characters.count > 3 ? uppercaseedFirstChar(for: $0) : $0.uppercased() }
        otherStringArray.insert(firstWord, at: 0)
        
        return otherStringArray.joined()
    }
}
