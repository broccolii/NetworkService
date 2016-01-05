//
//  DSAPI.Swift
//  NetworkService
//
//  Created by Broccoli on 16/1/4.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import Foundation
import Moya

/**
 MARK: 创建DS 请求方法列表
*/

public enum Network {
    case GetNetworkData()
}

let BRProvider = MoyaProvider<Network>()

extension Network: TargetType {
    // base URL
    public var baseURL: NSURL {
        return NSURL(string: "http://192.168.0.200:8080/console/test/")!
    }
    
    /// 拼接请求字符串
    public var path: String {
        switch self {
        case .GetNetworkData():
            return ("testModel")
        }
    }
    
    /// 请求方法
    public var method: Moya.Method {
        return .POST
    }
    
    /// 配置参数
    public var parameters: [String: AnyObject]? {
        switch self {
        default:
            return nil
        }
    }
    /// 数据
    public var sampleData: NSData {
        switch self {
        case .GetNetworkData:
            debugPrint(self.sampleData)
            return "Half measures are as bad as nothing at all.".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}