//
//  toInt.swift
//  SwiftDailyAPI
//
//  Created by Nicholas Tian on 31/05/2015.
//  Copyright (c) 2015 nickTD. All rights reserved.
//

import Foundation
import Argo

public func toNSDate(format: String)(dateString: String) -> Decoded<NSDate> {
  return .fromOptional(NSDate.dateFromString(dateString, format: format))
}

public func toNSDate(fromTimeStamp fromTimeStamp: NSTimeInterval) -> Decoded<NSDate> {
  return pure(NSDate(timeIntervalSince1970: fromTimeStamp))
}

public func toInt(string: String) -> Decoded<Int> {
  return .fromOptional(Int(string))
}

// MARK: String
extension NSDate {
    public class func dateFromString(string: String, format: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.dateFromString(string)
    }
    
    public func toString(format format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
}
