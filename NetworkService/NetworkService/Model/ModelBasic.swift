//
//  TestModel.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/4.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import Foundation
import Mantle

class ModelBasic: MTLModel {
    var i: Int?
    var s: String?
    var b: Bool?
    var d: Double?
    var f: Double?
    var l: Int?
    var date: NSDate?
}

extension ModelBasic: MTLJSONSerializing {
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [:]
    }
}