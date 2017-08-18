//
//  JsonDeserializeable.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol JsonDeserializeable {
    init?(jsonDictionary: JsonDictionary?)
    init?(jsonString: String?)
    
    // 以下需struct各自實作
    init()
    mutating func jsonMapping(_ jsonDictionary: JsonDictionary)
}

extension JsonDeserializeable
{
    public init?(jsonDictionary: JsonDictionary?)
    {
        guard let jsonDictionary = jsonDictionary else {
            return nil
        }

        self.init()
    
        jsonMapping(jsonDictionary)
    }
    
    public init?(jsonString: String?)
    {
        guard let data = jsonString?.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        self.init()
        
        do
        {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

            switch jsonObject {
            case let jsonDictionary as JsonDictionary:
                jsonMapping(jsonDictionary)
                
            default:
                #if DEBUG
                    print("\r\nJson反序列化(未實作的Type): \r\n\(type(of: jsonObject))")
                #endif
            }
        }
        catch let error
        {
            #if DEBUG
                print("\r\nJson反序列化(catch error): \r\n\(error.localizedDescription)")
            #endif
            
            return nil
        }
    }
}
