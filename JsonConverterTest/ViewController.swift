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
    
    @IBAction func printJsonDecodableModel(_ sender: Any) {
        let jsonString: String = "{\"metadata\":{\"status\":\"0000\",\"desc\":\"\"},\"data\":{\"uncommented_orders\":[{\"id\":\"17KK111111\",\"prod_name\":\"product name\",\"img_url\":\"https://img.sit.kkday.com/image/get/w_600%2Cc_fit/s1.kkday.com/product_2173/20150528034717_QInp9/jpg\",\"lst_dt_go\":\"2017-11-11 (Taipei)\"}]}}"
        let jsonModel: String = jsonString.jsonDecodableModel
        
        print(jsonModel)
    }

    @IBAction func printJsonModel(_ sender: UIButton) {
        let jsonString: String = "{\"metadata\":{\"status\":\"0000\",\"desc\":\"\"},\"data\":{\"uncommented_orders\":[{\"id\":\"17KK111111\",\"prod_name\":\"product name\",\"img_url\":\"https://img.sit.kkday.com/image/get/w_600%2Cc_fit/s1.kkday.com/product_2173/20150528034717_QInp9/jpg\",\"lst_dt_go\":\"2017-11-11 (Taipei)\"}]}}"
        let jsonModel: String = jsonString.jsonModel
        
        print(jsonModel)
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
    
    
}
