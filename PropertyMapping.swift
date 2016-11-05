//
//  ParameterProtocol.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/22.
//  Copyright © 2015年 Bobson. All rights reserved.
//

public protocol PropertyMapping
{
    /**
     * (propertyName, JsonName)
     */
    func propertyMapping() -> [(String?, String?)]
}
