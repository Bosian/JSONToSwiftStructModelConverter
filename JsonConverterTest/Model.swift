//
//  Model.swift
//  JsonConverterTest
//
//  Created by Bobson on 2017/2/8.
//  Copyright © 2017年 劉柏賢. All rights reserved.
//

import UIKit

public struct Model: JsonSerializeable {
    
    public let name: String = "名字"
    public let age: Int = 18
    
    public let skill: [Skill]
    public let native: [String]?
    public var other: Other?
    
    public init(skill: [Skill], other: Other? = nil, native: [String]? = nil) {
        self.skill = skill
        self.other = other
        self.native = native
    }
}

extension Model {
    
    public struct Skill: JsonSerializeable, PropertyMapping, PropertyConverters {
        public let name: String
        
        public init(name: String) {
            self.name = name
        }
        
        public func propertyMapping() -> [(String?, String?)] {
            return [
                ("name", "Name")
            ]
        }
        
        public func propertyConverters() -> [(String?, (Any?) -> (), () -> Any?)] {
            return [
                (
                    "name",
                    { (value) in
                        
                    },
                    { () -> Any? in
                        return "名稱" + self.name
                    }
                )
            ]
        }
    }
    
    public struct Other: JsonSerializeable {
        public let info: String
        
        public init(info: String) {
            self.info = info
        }
    }
}
