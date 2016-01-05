//
//  ModelMiddle.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/4.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import Foundation
import Mantle

class ModelMiddle: MTLModel {
    var i: Int?
    var s: String?
    var b: Bool?
    var d: Double?
    var f: Double?
    var l: Int?
    var date: NSDate?
    var md: [ModelBasic]?
    var modelBasic: ModelBasic?
    
    static func modelBasicJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer(usingForwardBlock: { (value, bool, error) -> AnyObject! in
            let model = try! MTLJSONAdapter.modelOfClass(ModelBasic.self, fromJSONDictionary: value as! [NSObject : AnyObject])
            return model
        })
    }
    
    static func mdJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer(usingReversibleBlock: { (value, bool, error) -> AnyObject! in
            let model = try! MTLJSONAdapter.modelsOfClass(ModelBasic.self, fromJSONArray: value as! [AnyObject])
            return model
        })
    }
}

extension ModelMiddle: MTLJSONSerializing {
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "modelBasic":"modelBasic"]
    }
}