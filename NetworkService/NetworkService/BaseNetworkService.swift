//
//  BaseService.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/5.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import Foundation

// 第一个 request 是用来判断 是否有网络请求 如果为 nil 那么就是从 cache 里面读取的数据
// 第二个 object 是 response 对象 一般是 json 数据
// NSError 这里保存一些 错误信息 在外部 可以 自定义 error 对象 用来 throw 错误
typealias ServiceResponseBlock = (NSURLRequest, AnyObject, NSError) -> Void

public let kHttpMethodPOST = "POST"
public let kHttpMethodGET = "GET"

// 读取 Cache 的几种类型
struct CachePolicy : OptionSetType {
    let rawValue: Int
    // 直接网络获取数据 不管本地的 Cache
    static let CachePolicyNone = CachePolicy(rawValue: 0)
    // 读取本地 Cache (可能会有失效)
    static let CachePolicyReadCache = CachePolicy(rawValue: 1 << 0)
    // 只读 有效的 Cache
    static let CachePolicyReadValidCache = CachePolicy(rawValue: 1 << 1)
    // 网络获取 同时写入 Cache
    static let CachePolicyWriteToCache  = CachePolicy(rawValue: 1 << 2)
    // 不网络获取
    static let CachePolicyDoNotLoadFromServer  = CachePolicy(rawValue: 1 << 3)
}

class BaseNetwrokCache {
    var data: NSData?
    var attributes: [String : AnyObject]?
    var cacheTime: NSTimeInterval {
        return -self.attributes![NSFileCreationDate]!.timeIntervalSinceNow
    }
}


class BaseNetworkManager {
    // 最简单 最好的单例方法
    static let sharedInstance = BaseNetworkManager()
    private init() {}
    /*************************************数据请求*****************************************/
    /**
     数据请求
     
     - parameter parameters:      <#parameters description#>
     - parameter apiPath:         <#apiPath description#>
     - parameter HTTPMethod:      <#HTTPMethod description#>
     - parameter cachePolicy:     <#cachePolicy description#>
     - parameter completionBlock: <#completionBlock description#>
     */
    class func startDataTaskWithParameters(parameters: [String : AnyObject], apiPath: String, HTTPMethod: String, cachePolicy: CachePolicy, completionBlock: ServiceResponseBlock) {
        // 这里面 放 Alamofire 的源码  然后这里 可以选择返回一下 request 之类的东西 到时候在讨论
    }
    
    
    
    /*************************************图片上传*****************************************/
    /**
     图片上传 file 的形式
     
     - parameter parameters:         <#parameters description#>
     - parameter apiPath:            <#apiPath description#>
     - parameter HTTPMethod:         <#HTTPMethod description#>
     - parameter multipartDataBlock: <#multipartDataBlock description#>
     - parameter progress:           <#progress description#>
     - parameter completionBlock:    <#completionBlock description#>
     */
    class func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, HTTPMethod: String, multipartDataBlock: () -> Void, progress: CGFloat, completionBlock: ServiceResponseBlock) {
        // Alamofire 上传 图片的方法
    }
    
    /**
     图片上传 data 的形式
     
     - parameter parameters:      <#parameters description#>
     - parameter apiPath:         <#apiPath description#>
     - parameter HTTPMethod:      <#HTTPMethod description#>
     - parameter multipartData:   <#multipartData description#>
     - parameter progress:        <#progress description#>
     - parameter completionBlock: <#completionBlock description#>
     */
    class func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, HTTPMethod: String, multipartData: NSData, progress: CGFloat, completionBlock: ServiceResponseBlock) {
        // Alamofire 上传 图片的方法
    }
    
    /**
     图片上传 File 的形式
     
     - parameter parameters:        <#parameters description#>
     - parameter apiPath:           <#apiPath description#>
     - parameter HTTPMethod:        <#HTTPMethod description#>
     - parameter multipartFilePath: <#multipartFilePath description#>
     - parameter progress:          <#progress description#>
     - parameter completionBlock:   <#completionBlock description#>
     */
    class func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, HTTPMethod: String, multipartFilePath: [NSURL], progress: CGFloat, completionBlock: ServiceResponseBlock) {
        // Alamofire 上传 图片的方法
    }
    
    /*************************************缓存机制*****************************************/
    
    class func requestWithParameters(parameters: Dictionary) {
        // 这里 如果是 通过 GET 方法 需要把参数传进来
//        return path
    }
    class func cacheForRequest(path: String) -> BaseNetwrokCache {
        // 这里 通过 请求路径 读取 本地的缓存
        return BaseNetwrokCache()
    }
    
}


/*************************************自定义错误类型*****************************************/
// 这一部分的错误形式和信息 我还没想好要怎么弄 先 放一个在这里
enum BaseNetworkError: ErrorType {
    case NoCache
}

/**
 简单的例子
 */
func getCache() throws {
    if foo() {
        
    } else {
         throw BaseNetworkError.NoCache
    }
}