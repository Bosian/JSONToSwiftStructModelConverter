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
        let jsonString = "{\"metadata\":{\"status\":\"0000\",\"desc\":\"\"},\"data\":{\"continents\":[{\"continent_id\":\"A01\",\"name\":\"Asia\",\"countries\":[{\"country_id\":\"A01-001\",\"name\":\"Taiwan\",\"cities\":[{\"city_id\":\"A01-001-00001\",\"name\":\"Taipei\"},{\"city_id\":\"A01-001-00002\",\"name\":\"Taichung\"},{\"city_id\":\"A01-001-00003\",\"name\":\"Tainan\"},{\"city_id\":\"A01-001-00004\",\"name\":\"Kaohsiung\"},{\"city_id\":\"A01-001-00005\",\"name\":\"Hualien\"},{\"city_id\":\"A01-001-00006\",\"name\":\"New Taipei City\"},{\"city_id\":\"A01-001-00008\",\"name\":\"Taoyuan\"},{\"city_id\":\"A01-001-00009\",\"name\":\"Hsinchu\"},{\"city_id\":\"A01-001-00010\",\"name\":\"Miaoli\"},{\"city_id\":\"A01-001-00011\",\"name\":\"Changhua\"},{\"city_id\":\"A01-001-00012\",\"name\":\"Nantou\"},{\"city_id\":\"A01-001-00013\",\"name\":\"Yunlin\"},{\"city_id\":\"A01-001-00014\",\"name\":\"Chiayi\"},{\"city_id\":\"A01-001-00015\",\"name\":\"Pingtung\"},{\"city_id\":\"A01-001-00016\",\"name\":\"Kenting\"},{\"city_id\":\"A01-001-00017\",\"name\":\"Yilan\"},{\"city_id\":\"A01-001-00018\",\"name\":\"Taitung\"},{\"city_id\":\"A01-001-00019\",\"name\":\"Penghu\"},{\"city_id\":\"A01-001-00022\",\"name\":\"Lanyu\"},{\"city_id\":\"A01-001-00023\",\"name\":\"Green Island\"},{\"city_id\":\"A01-001-00026\",\"name\":\"Keelung\"}]},{\"country_id\":\"A01-002\",\"name\":\"China\",\"cities\":[{\"city_id\":\"A01-002-00001\",\"name\":\"Beijing\"},{\"city_id\":\"A01-002-00002\",\"name\":\"Hangzhou\"},{\"city_id\":\"A01-002-00003\",\"name\":\"Chengdu\"},{\"city_id\":\"A01-002-00005\",\"name\":\"Guilin\"},{\"city_id\":\"A01-002-00008\",\"name\":\"Shanghai\"},{\"city_id\":\"A01-002-00009\",\"name\":\"Xian\"},{\"city_id\":\"A01-002-00022\",\"name\":\"Nanjing\"},{\"city_id\":\"A01-002-00023\",\"name\":\"Suzhou\"},{\"city_id\":\"A01-002-00039\",\"name\":\"Tibet\"},{\"city_id\":\"A01-002-00047\",\"name\":\"Sichuan\"},{\"city_id\":\"A01-002-00051\",\"name\":\"Guangdong\"}]},{\"country_id\":\"A01-003\",\"name\":\"Japan\",\"cities\":[{\"city_id\":\"A01-003-00001\",\"name\":\"Tokyo\"},{\"city_id\":\"A01-003-00002\",\"name\":\"Osaka\"},{\"city_id\":\"A01-003-00003\",\"name\":\"Kyoto\"},{\"city_id\":\"A01-003-00004\",\"name\":\"Sapporo\"},{\"city_id\":\"A01-003-00005\",\"name\":\"Hokkaido\"},{\"city_id\":\"A01-003-00006\",\"name\":\"Nara\"},{\"city_id\":\"A01-003-00007\",\"name\":\"Kanagawa\"},{\"city_id\":\"A01-003-00008\",\"name\":\"Mie\"},{\"city_id\":\"A01-003-00009\",\"name\":\"Shizuoka\"},{\"city_id\":\"A01-003-00010\",\"name\":\"Yamanashi\"},{\"city_id\":\"A01-003-00011\",\"name\":\"Hiroshima\"},{\"city_id\":\"A01-003-00012\",\"name\":\"Tochigi\"},{\"city_id\":\"A01-003-00013\",\"name\":\"Okinawa\"},{\"city_id\":\"A01-003-00014\",\"name\":\"Toyama\"},{\"city_id\":\"A01-003-00015\",\"name\":\"Gifu\"},{\"city_id\":\"A01-003-00016\",\"name\":\"Gunma\"},{\"city_id\":\"A01-003-00017\",\"name\":\"Nagano\"},{\"city_id\":\"A01-003-00018\",\"name\":\"Oita\"},{\"city_id\":\"A01-003-00020\",\"name\":\"Ibaraki\"},{\"city_id\":\"A01-003-00021\",\"name\":\"Niigata\"},{\"city_id\":\"A01-003-00022\",\"name\":\"Hyogo\"},{\"city_id\":\"A01-003-00023\",\"name\":\"Kochi\"},{\"city_id\":\"A01-003-00024\",\"name\":\"Tokushima\"},{\"city_id\":\"A01-003-00025\",\"name\":\"Shiga\"},{\"city_id\":\"A01-003-00026\",\"name\":\"Aichi\"},{\"city_id\":\"A01-003-00027\",\"name\":\"Nagoya\"},{\"city_id\":\"A01-003-00028\",\"name\":\"Kobe\"},{\"city_id\":\"A01-003-00031\",\"name\":\"Akita\"},{\"city_id\":\"A01-003-00033\",\"name\":\"Ishikawa\"},{\"city_id\":\"A01-003-00034\",\"name\":\"Fukui\"},{\"city_id\":\"A01-003-00035\",\"name\":\"Okayama\"},{\"city_id\":\"A01-003-00036\",\"name\":\"Wakayama\"},{\"city_id\":\"A01-003-00037\",\"name\":\"Fukushima\"},{\"city_id\":\"A01-003-00038\",\"name\":\"Kagawa\"},{\"city_id\":\"A01-003-00039\",\"name\":\"Chiba\"},{\"city_id\":\"A01-003-00040\",\"name\":\"Fukuoka\"},{\"city_id\":\"A01-003-00041\",\"name\":\"Nagasaki\"},{\"city_id\":\"A01-003-00043\",\"name\":\"Yamagata\"},{\"city_id\":\"A01-003-00044\",\"name\":\"Kumamoto\"},{\"city_id\":\"A01-003-00045\",\"name\":\"Miyazaki\"},{\"city_id\":\"A01-003-00046\",\"name\":\"Kagojima\"},{\"city_id\":\"A01-003-00047\",\"name\":\"kyushu\"},{\"city_id\":\"A01-003-00049\",\"name\":\"Ehime\"},{\"city_id\":\"A01-003-00050\",\"name\":\"Tottori\"},{\"city_id\":\"A01-003-00051\",\"name\":\"Saga\"}]},{\"country_id\":\"A01-004\",\"name\":\"Korea\",\"cities\":[{\"city_id\":\"A01-004-00001\",\"name\":\"Seoul\"},{\"city_id\":\"A01-004-00002\",\"name\":\"Busan\"},{\"city_id\":\"A01-004-00003\",\"name\":\"Gangwon\"},{\"city_id\":\"A01-004-00004\",\"name\":\"Jeonnam\"},{\"city_id\":\"A01-004-00005\",\"name\":\"Gyeongju\"},{\"city_id\":\"A01-004-00006\",\"name\":\"Gyeongnam\"},{\"city_id\":\"A01-004-00007\",\"name\":\"Gyeonggi\"},{\"city_id\":\"A01-004-00008\",\"name\":\"Jeonbuk\"},{\"city_id\":\"A01-004-00010\",\"name\":\"Chungnam\"},{\"city_id\":\"A01-004-00011\",\"name\":\"Gyeongbuk\"},{\"city_id\":\"A01-004-00012\",\"name\":\"Jeju\"},{\"city_id\":\"A01-004-00013\",\"name\":\"Suwon\"},{\"city_id\":\"A01-004-00014\",\"name\":\"Gimpo\"},{\"city_id\":\"A01-004-00015\",\"name\":\"Incheon\"},{\"city_id\":\"A01-004-00016\",\"name\":\"Jeonju\"},{\"city_id\":\"A01-004-00019\",\"name\":\"Daegu\"}]},{\"country_id\":\"A01-005\",\"name\":\"Hong Kong and Macau\",\"cities\":[{\"city_id\":\"A01-005-00001\",\"name\":\"Hong Kong\"},{\"city_id\":\"A01-005-00002\",\"name\":\"Macau\"}]},{\"country_id\":\"A01-006\",\"name\":\"Laos\",\"cities\":[{\"city_id\":\"A01-006-00001\",\"name\":\"Vientiane\"},{\"city_id\":\"A01-006-00002\",\"name\":\"Luang Prabang\"}]},{\"country_id\":\"A01-007\",\"name\":\"Myanmar\",\"cities\":[{\"city_id\":\"A01-007-00001\",\"name\":\"Yangon\"},{\"city_id\":\"A01-007-00003\",\"name\":\"Mandalay\"},{\"city_id\":\"A01-007-00004\",\"name\":\"Nyaung Shwe\"},{\"city_id\":\"A01-007-00005\",\"name\":\"Taunggyi\"},{\"city_id\":\"A01-007-00006\",\"name\":\"Bagan\"}]},{\"country_id\":\"A01-008\",\"name\":\"Philippines\",\"cities\":[{\"city_id\":\"A01-008-00001\",\"name\":\"Manila\"},{\"city_id\":\"A01-008-00002\",\"name\":\"Cebu\"},{\"city_id\":\"A01-008-00003\",\"name\":\"Boracay\"},{\"city_id\":\"A01-008-00006\",\"name\":\"Palawan\"},{\"city_id\":\"A01-008-00008\",\"name\":\"Dumaguete\"},{\"city_id\":\"A01-008-00009\",\"name\":\"Bohol\"},{\"city_id\":\"A01-008-00010\",\"name\":\"Oslob\"}]},{\"country_id\":\"A01-009\",\"name\":\"Malaysia\",\"cities\":[{\"city_id\":\"A01-009-00001\",\"name\":\"Penang\"},{\"city_id\":\"A01-009-00002\",\"name\":\"Langkawi\"},{\"city_id\":\"A01-009-00003\",\"name\":\"Kuching\"},{\"city_id\":\"A01-009-00004\",\"name\":\"Kuala  Lumpur\"},{\"city_id\":\"A01-009-00005\",\"name\":\"Sabah-Kota Kinabalu\"},{\"city_id\":\"A01-009-00008\",\"name\":\"Johor Baru\"},{\"city_id\":\"A01-009-00009\",\"name\":\"Sabah-Sandakan\"},{\"city_id\":\"A01-009-00010\",\"name\":\"Malacca\"},{\"city_id\":\"A01-009-00011\",\"name\":\"Ipoh\"},{\"city_id\":\"A01-009-00012\",\"name\":\"Kuantan\"},{\"city_id\":\"A01-009-00014\",\"name\":\"Sabah- Tawau and Semporna\"},{\"city_id\":\"A01-009-00016\",\"name\":\"Miri\"}]},{\"country_id\":\"A01-010\",\"name\":\"Thailand\",\"cities\":[{\"city_id\":\"A01-010-00001\",\"name\":\"Bangkok\"},{\"city_id\":\"A01-010-00002\",\"name\":\"Phuket\"},{\"city_id\":\"A01-010-00003\",\"name\":\"Chiang Mai\"},{\"city_id\":\"A01-010-00004\",\"name\":\"Chiang Rai\"},{\"city_id\":\"A01-010-00005\",\"name\":\"Koh Samui\"},{\"city_id\":\"A01-010-00006\",\"name\":\"Krabi\"},{\"city_id\":\"A01-010-00007\",\"name\":\"Pattaya\"},{\"city_id\":\"A01-010-00008\",\"name\":\"Hua Hin\"},{\"city_id\":\"A01-010-00009\",\"name\":\"Koh Chang\"},{\"city_id\":\"A01-010-00012\",\"name\":\"Kanchanaburi\"},{\"city_id\":\"A01-010-00013\",\"name\":\"Khao Lak\"},{\"city_id\":\"A01-010-00014\",\"name\":\"Rayong\"},{\"city_id\":\"A01-010-00018\",\"name\":\"Koh Lanta\"}]},{\"country_id\":\"A01-011\",\"name\":\"Vietnam\",\"cities\":[{\"city_id\":\"A01-011-00001\",\"name\":\"Hanoi\"},{\"city_id\":\"A01-011-00002\",\"name\":\"Ho Chi Minh\"},{\"city_id\":\"A01-011-00004\",\"name\":\"Ha Long Bay\"},{\"city_id\":\"A01-011-00005\",\"name\":\"Sapa\"},{\"city_id\":\"A01-011-00006\",\"name\":\"Hoi An\"},{\"city_id\":\"A01-011-00007\",\"name\":\"Da Nang\"},{\"city_id\":\"A01-011-00008\",\"name\":\"Hue\"},{\"city_id\":\"A01-011-00009\",\"name\":\"Nha Trang\"},{\"city_id\":\"A01-011-00010\",\"name\":\"Da Lat\"},{\"city_id\":\"A01-011-00011\",\"name\":\"Phu Quoc\"},{\"city_id\":\"A01-011-00012\",\"name\":\"Mũi Né\"}]},{\"country_id\":\"A01-012\",\"name\":\"Indonesia\",\"cities\":[{\"city_id\":\"A01-012-00001\",\"name\":\"Bali\"},{\"city_id\":\"A01-012-00002\",\"name\":\"Ubud\"},{\"city_id\":\"A01-012-00004\",\"name\":\"Jakarta\"},{\"city_id\":\"A01-012-00005\",\"name\":\"Yogyakarta\"}]},{\"country_id\":\"A01-013\",\"name\":\"Singapore\",\"cities\":[{\"city_id\":\"A01-013-00001\",\"name\":\"Singapore\"}]},{\"country_id\":\"A01-014\",\"name\":\"Cambodia\",\"cities\":[{\"city_id\":\"A01-014-00001\",\"name\":\"Angkor Wat\"},{\"city_id\":\"A01-014-00002\",\"name\":\"Phnom Penh\"},{\"city_id\":\"A01-014-00003\",\"name\":\"Siem Reap\"},{\"city_id\":\"A01-014-00005\",\"name\":\"Sihanoukville\"}]},{\"country_id\":\"A01-015\",\"name\":\"India\",\"cities\":[]},{\"country_id\":\"A01-017\",\"name\":\"Bhutan\",\"cities\":[{\"city_id\":\"A01-017-00001\",\"name\":\"Bhutan\"}]},{\"country_id\":\"A01-019\",\"name\":\"UnitedArabEmirates\",\"cities\":[{\"city_id\":\"A01-019-00002\",\"name\":\"Abu Dhabi\"}]}]},{\"continent_id\":\"A03\",\"name\":\"Europe\",\"countries\":[{\"country_id\":\"A03-001\",\"name\":\"Russia\",\"cities\":[{\"city_id\":\"A03-001-00002\",\"name\":\"Saint Petersburg\"}]},{\"country_id\":\"A03-002\",\"name\":\"Estonia\",\"cities\":[{\"city_id\":\"A03-002-00001\",\"name\":\"Tallinn\"}]},{\"country_id\":\"A03-003\",\"name\":\"Lithuania\",\"cities\":[]},{\"country_id\":\"A03-004\",\"name\":\"Germany\",\"cities\":[{\"city_id\":\"A03-004-00001\",\"name\":\"Berlin\"},{\"city_id\":\"A03-004-00002\",\"name\":\"Frankfurt\"},{\"city_id\":\"A03-004-00003\",\"name\":\"Cologne\"},{\"city_id\":\"A03-004-00004\",\"name\":\"Hamburg\"},{\"city_id\":\"A03-004-00005\",\"name\":\"Munich\"},{\"city_id\":\"A03-004-00009\",\"name\":\"Stuttgart\"},{\"city_id\":\"A03-004-00011\",\"name\":\"Bamberg\"},{\"city_id\":\"A03-004-00012\",\"name\":\"Mannheim\"}]},{\"country_id\":\"A03-005\",\"name\":\"Austria\",\"cities\":[{\"city_id\":\"A03-005-00001\",\"name\":\"Vienna\"},{\"city_id\":\"A03-005-00002\",\"name\":\"Insbruck\"},{\"city_id\":\"A03-005-00003\",\"name\":\"salzburg\"},{\"city_id\":\"A03-005-00005\",\"name\":\"Hallstatt\"}]},{\"country_id\":\"A03-006\",\"name\":\"Croatia\",\"cities\":[{\"city_id\":\"A03-006-00003\",\"name\":\"Dubrovnik\"}]},{\"country_id\":\"A03-007\",\"name\":\"Hungary\",\"cities\":[{\"city_id\":\"A03-007-00001\",\"name\":\"Budapest\"}]},{\"country_id\":\"A03-008\",\"name\":\"Turkey\",\"cities\":[{\"city_id\":\"A03-008-00001\",\"name\":\"Istanbul\"},{\"city_id\":\"A03-008-00002\",\"name\":\"Ankara\"},{\"city_id\":\"A03-008-00004\",\"name\":\"Bodrum\"},{\"city_id\":\"A03-008-00005\",\"name\":\"Cappadocia\"},{\"city_id\":\"A03-008-00006\",\"name\":\"Izmir\"},{\"city_id\":\"A03-008-00010\",\"name\":\"Pamukkale\"}]},{\"country_id\":\"A03-009\",\"name\":\"United Kingdom\",\"cities\":[{\"city_id\":\"A03-009-00001\",\"name\":\"London\"},{\"city_id\":\"A03-009-00002\",\"name\":\"Oxford\"},{\"city_id\":\"A03-009-00003\",\"name\":\"Liverpool\"},{\"city_id\":\"A03-009-00004\",\"name\":\"Lake District\"},{\"city_id\":\"A03-009-00005\",\"name\":\"Edinburgh\"}]},{\"country_id\":\"A03-010\",\"name\":\"Czech Republic\",\"cities\":[{\"city_id\":\"A03-010-00001\",\"name\":\"Prague\"},{\"city_id\":\"A03-010-00003\",\"name\":\"Olomouc\"},{\"city_id\":\"A03-010-00004\",\"name\":\"Brno\"}]},{\"country_id\":\"A03-011\",\"name\":\"The Netherlands\",\"cities\":[{\"city_id\":\"A03-011-00001\",\"name\":\"Amsterdam\"}]},{\"country_id\":\"A03-012\",\"name\":\"Italy\",\"cities\":[{\"city_id\":\"A03-012-00001\",\"name\":\"Rome\"},{\"city_id\":\"A03-012-00002\",\"name\":\"Florence\"},{\"city_id\":\"A03-012-00003\",\"name\":\"Venice\"},{\"city_id\":\"A03-012-00006\",\"name\":\"Milan\"}]},{\"country_id\":\"A03-013\",\"name\":\"France\",\"cities\":[{\"city_id\":\"A03-013-00001\",\"name\":\"Paris\"},{\"city_id\":\"A03-013-00002\",\"name\":\"Marseille\"},{\"city_id\":\"A03-013-00003\",\"name\":\"Nice\"},{\"city_id\":\"A03-013-00005\",\"name\":\"Avignon\"}]},{\"country_id\":\"A03-014\",\"name\":\"Spain\",\"cities\":[{\"city_id\":\"A03-014-00001\",\"name\":\"Barcelona\"},{\"city_id\":\"A03-014-00002\",\"name\":\"Madrid\"},{\"city_id\":\"A03-014-00004\",\"name\":\"Malaga\"},{\"city_id\":\"A03-014-00005\",\"name\":\"ibiza\"},{\"city_id\":\"A03-014-00006\",\"name\":\"Valencia\"},{\"city_id\":\"A03-014-00007\",\"name\":\"San Sebastian\"}]},{\"country_id\":\"A03-015\",\"name\":\"Belgium\",\"cities\":[{\"city_id\":\"A03-015-00001\",\"name\":\"Brussels\"}]},{\"country_id\":\"A03-016\",\"name\":\"Denmark\",\"cities\":[{\"city_id\":\"A03-016-00001\",\"name\":\"Copenhagen\"}]},{\"country_id\":\"A03-017\",\"name\":\"Finland\",\"cities\":[{\"city_id\":\"A03-017-00001\",\"name\":\"Helsinki\"}]},{\"country_id\":\"A03-018\",\"name\":\"Greece\",\"cities\":[{\"city_id\":\"A03-018-00001\",\"name\":\"Athens\"},{\"city_id\":\"A03-018-00003\",\"name\":\"Santorini\"},{\"city_id\":\"A03-018-00004\",\"name\":\"Peloponnese\"},{\"city_id\":\"A03-018-00005\",\"name\":\"Crete\"},{\"city_id\":\"A03-018-00006\",\"name\":\"Rhodes\"},{\"city_id\":\"A03-018-00007\",\"name\":\"Mykonos\"}]},{\"country_id\":\"A03-019\",\"name\":\"Switzerland\",\"cities\":[{\"city_id\":\"A03-019-00001\",\"name\":\"Zurich\"},{\"city_id\":\"A03-019-00002\",\"name\":\"Geneva\"}]},{\"country_id\":\"A03-020\",\"name\":\"Iceland\",\"cities\":[{\"city_id\":\"A03-020-00002\",\"name\":\"Reykjavik\"}]},{\"country_id\":\"A03-021\",\"name\":\"Ireland\",\"cities\":[{\"city_id\":\"A03-021-00001\",\"name\":\"Dublin\"},{\"city_id\":\"A03-021-00002\",\"name\":\"Killarney\"}]},{\"country_id\":\"A03-022\",\"name\":\"Sweden\",\"cities\":[{\"city_id\":\"A03-022-00001\",\"name\":\"Stockholm\"}]},{\"country_id\":\"A03-023\",\"name\":\"Portugal\",\"cities\":[{\"city_id\":\"A03-023-00001\",\"name\":\"Lisbon\"},{\"city_id\":\"A03-023-00002\",\"name\":\"Porto\"}]},{\"country_id\":\"A03-024\",\"name\":\"Norway\",\"cities\":[{\"city_id\":\"A03-024-00001\",\"name\":\"Oslo\"}]},{\"country_id\":\"A03-025\",\"name\":\"Poland\",\"cities\":[{\"city_id\":\"A03-025-00001\",\"name\":\"Warsaw\"},{\"city_id\":\"A03-025-00002\",\"name\":\"Krakow\"}]},{\"country_id\":\"A03-026\",\"name\":\"Monaco\",\"cities\":[{\"city_id\":\"A03-026-00001\",\"name\":\"Monaco\"}]},{\"country_id\":\"A03-027\",\"name\":\"Malta\",\"cities\":[{\"city_id\":\"A03-027-00001\",\"name\":\"Valletta\"}]},{\"country_id\":\"A03-028\",\"name\":\"Ukraine\",\"cities\":[{\"city_id\":\"A03-028-00001\",\"name\":\"Kyiv\"}]}]},{\"continent_id\":\"A04\",\"name\":\"South America\",\"countries\":[{\"country_id\":\"A04-001\",\"name\":\"Brazil\",\"cities\":[{\"city_id\":\"A04-001-00002\",\"name\":\"Foz do Iguacu\"},{\"city_id\":\"A04-001-00003\",\"name\":\"Manaus\"},{\"city_id\":\"A04-001-00006\",\"name\":\"Rio de Janeiro\"},{\"city_id\":\"A04-001-00008\",\"name\":\"São Paulo\"}]},{\"country_id\":\"A04-002\",\"name\":\"Chile\",\"cities\":[{\"city_id\":\"A04-002-00004\",\"name\":\"Easter Island\"}]},{\"country_id\":\"A04-008\",\"name\":\"Peru\",\"cities\":[{\"city_id\":\"A04-008-00002\",\"name\":\"Cusco\"},{\"city_id\":\"A04-008-00003\",\"name\":\"Lima\"}]}]},{\"continent_id\":\"A05\",\"name\":\"North America\",\"countries\":[{\"country_id\":\"A05-001\",\"name\":\"United States\",\"cities\":[{\"city_id\":\"A05-001-00001\",\"name\":\"New York City\"},{\"city_id\":\"A05-001-00002\",\"name\":\"Boston\"},{\"city_id\":\"A05-001-00003\",\"name\":\"Orlando\"},{\"city_id\":\"A05-001-00004\",\"name\":\"Miami\"},{\"city_id\":\"A05-001-00005\",\"name\":\"Washington D.C.\"},{\"city_id\":\"A05-001-00006\",\"name\":\"Las Vegas\"},{\"city_id\":\"A05-001-00007\",\"name\":\"Los Angeles\"},{\"city_id\":\"A05-001-00008\",\"name\":\"San Francisco\"},{\"city_id\":\"A05-001-00009\",\"name\":\"Chicago\"},{\"city_id\":\"A05-001-00010\",\"name\":\"San Diego\"},{\"city_id\":\"A05-001-00011\",\"name\":\"Hawaii\"},{\"city_id\":\"A05-001-00012\",\"name\":\"Seattle\"},{\"city_id\":\"A05-001-00019\",\"name\":\"Philadelphia\"},{\"city_id\":\"A05-001-00020\",\"name\":\"Houston\"},{\"city_id\":\"A05-001-00021\",\"name\":\"Salt Lake City\"},{\"city_id\":\"A05-001-00022\",\"name\":\"Denver\"}]},{\"country_id\":\"A05-002\",\"name\":\"Canada\",\"cities\":[{\"city_id\":\"A05-002-00001\",\"name\":\"Vancouver\"},{\"city_id\":\"A05-002-00002\",\"name\":\"Toronto\"}]},{\"country_id\":\"A05-003\",\"name\":\"Mexico\",\"cities\":[{\"city_id\":\"A05-003-00002\",\"name\":\"Mexico City\"},{\"city_id\":\"A05-003-00004\",\"name\":\"Cancun\"}]}]},{\"continent_id\":\"A06\",\"name\":\"Oceania\",\"countries\":[{\"country_id\":\"A06-001\",\"name\":\"Australia\",\"cities\":[{\"city_id\":\"A06-001-00001\",\"name\":\"Melbourne\"},{\"city_id\":\"A06-001-00002\",\"name\":\"Sydney\"},{\"city_id\":\"A06-001-00003\",\"name\":\"Perth\"},{\"city_id\":\"A06-001-00004\",\"name\":\"Canberra\"},{\"city_id\":\"A06-001-00005\",\"name\":\"Cairns\"},{\"city_id\":\"A06-001-00007\",\"name\":\"Gold Coast\"},{\"city_id\":\"A06-001-00008\",\"name\":\"Brisbane\"},{\"city_id\":\"A06-001-00009\",\"name\":\"Adelaide\"},{\"city_id\":\"A06-001-00010\",\"name\":\"Tasmania\"},{\"city_id\":\"A06-001-00011\",\"name\":\"Uluru\"},{\"city_id\":\"A06-001-00012\",\"name\":\"Darwin\"},{\"city_id\":\"A06-001-00013\",\"name\":\"Broome\"},{\"city_id\":\"A06-001-00014\",\"name\":\"Whitsundays\"},{\"city_id\":\"A06-001-00015\",\"name\":\"Alice Springs\"}]},{\"country_id\":\"A06-002\",\"name\":\"New Zealand\",\"cities\":[{\"city_id\":\"A06-002-00001\",\"name\":\"Queenstown\"},{\"city_id\":\"A06-002-00005\",\"name\":\"Christchurch\"},{\"city_id\":\"A06-002-00006\",\"name\":\"South Island\"},{\"city_id\":\"A06-002-00007\",\"name\":\"North Island\"}]},{\"country_id\":\"A06-003\",\"name\":\"Guam\",\"cities\":[{\"city_id\":\"A06-003-00001\",\"name\":\"Guam\"}]}]},{\"continent_id\":\"A08\",\"name\":\"Africa\",\"countries\":[{\"country_id\":\"A08-003\",\"name\":\"South Africa\",\"cities\":[{\"city_id\":\"A08-003-00001\",\"name\":\"Cape Town\"}]}]},{\"continent_id\":\"A09\",\"name\":\"Central America\",\"countries\":[{\"country_id\":\"A09-002\",\"name\":\"Puerto Rico\",\"cities\":[{\"city_id\":\"A09-002-00001\",\"name\":\"San Juan\"},{\"city_id\":\"A09-002-00002\",\"name\":\"Ponce\"}]},{\"country_id\":\"A09-003\",\"name\":\"Dominican Republic\",\"cities\":[{\"city_id\":\"A09-003-00001\",\"name\":\"Santo Domingo\"},{\"city_id\":\"A09-003-00002\",\"name\":\"Punta Cana\"}]},{\"country_id\":\"A09-004\",\"name\":\"Panama\",\"cities\":[{\"city_id\":\"A09-004-00001\",\"name\":\"Panama City\"}]}]}]}}"
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

                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].stringOrDefault")
                
            case _ as Int:
                
                let defaultValue = -1
                print("\(tabSapce)public var \(key): Int = \(defaultValue)")
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].intOrDefault")
                
            case _ as Double:
                print("\(tabSapce)public var \(key): Double = 0.0")
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].doubleOrDefault")
                
            case _ as [String]:
                print("\(tabSapce)public var \(key): [String] = []")
                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].stringArrayOrDefault")
                
//            case _ as [Int]:
//                print("\(tabSapce)public var \(key): [Int] = []")
//                pendingJsonMapping.append("self.\(key) = jsonDictionary[\"\(key)\"].intArrayOrDefault")
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
                pendingJsonMapping.append("self.\(key) = [\(typeName)](jsonArray: jsonDictionary[\"\(key)\"].jsonArrayOrDefault)")
                
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
