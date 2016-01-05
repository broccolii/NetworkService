//
//  ModelTop.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/4.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import Foundation
import Mantle

@objc class ModelTop: MTLModel {
    var iii: Int = 0
    var s: String?
    var b: Bool = false
    var d: CGFloat = 0.0
    var f: Double = 0.0
    var l: Int = 0
    var date: NSDate?
    var mm: [ModelMiddle]?
    var modelMiddle: ModelMiddle?
}

extension ModelTop: MTLJSONSerializing {
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["iii":"iii",
            "b":"b",
            "d":"d",
            "s":"s",
            "date":"date",
            "mm":"mm",
            "modelMiddle":"modelMiddle"]
    }
    override func setNilValueForKey(key: String) {
        if key == "d" {
            d = 0.0
        }
    }
    static func dateFormatter() -> NSDateFormatter{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
  
    class func bJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLBooleanValueTransformerName)!
    }
    
    static func modelMiddleJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer(usingForwardBlock: { (value, bool, error) -> AnyObject! in
            let model = try! MTLJSONAdapter.modelOfClass(ModelMiddle.self, fromJSONDictionary: value as! [NSObject : AnyObject])
            return model
        })
    }
    
    static func mmJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer(usingReversibleBlock: { (value, bool, error) -> AnyObject! in
            let model = try! MTLJSONAdapter.modelsOfClass(ModelMiddle.self, fromJSONArray: value as! [AnyObject])
            return model
        })
    }
    
    static func dateJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer(usingForwardBlock: { (value, bool, error) -> AnyObject! in
            return self.dateFormatter().dateFromString(String(value)) as! AnyObject
            }, reverseBlock: { (date, success, error) -> AnyObject! in
                return self.dateFormatter().stringFromDate(date as! NSDate)
        })
    }
}