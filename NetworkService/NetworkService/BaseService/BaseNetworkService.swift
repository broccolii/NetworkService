//
//  BaseService.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/5.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Argo


public let kHttpMethodPOST = "POST"
public let kHttpMethodGET = "GET"

class BaseNetworkCache {
    var data: NSData?
    var attributes: [String : AnyObject]?
    var cacheTime: NSTimeInterval {
        return -self.attributes![NSFileCreationDate]!.timeIntervalSinceNow
    }
}

protocol BaseNetworkDataTaskProtocol {
    func startDataTaskWithParameters(parameters: [String : AnyObject], apiPath: String, cachePolicy: CachePolicy) -> Observable<[String : AnyObject]>
}

protocol BaseNetworkUploadTaskProtocol {
    static func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, multipartDataBlock: () -> Void, progress: Double, completionBlock: ServiceResponseBlock)
    static func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, multipartData: NSData, progress: Double, completionBlock: ServiceResponseBlock)
    static func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, multipartFilePath: [NSURL], progress: Double, completionBlock: ServiceResponseBlock)
}

protocol BaseNetworkCacheProtocol {
    /*************************************缓存机制*****************************************/
    
    static func requestWithParameters(parameters: [String : AnyObject])
    static func cacheForRequest(path: String) -> BaseNetworkCache
}

/*************************************自定义错误类型*****************************************/
 // 这一部分的错误形式和信息 我还没想好要怎么弄 先 放一个在这里
enum BaseNetworkError: ErrorType {
    case NoData
}





let URL = "http://192.168.0.200:8080/console/picture"
let HTTPHeader = ["os":"android","version":"1.0.0.2","token":"FGG442GK240GQ40G4QGQ4GJQQSLLQ"]

extension BaseNetworkDataTaskProtocol {
  
    /*************************************数据请求*****************************************/

    // TODO: - 超时时间设置
    func startDataTaskWithParameters(parameters: [String : AnyObject], apiPath: String, cachePolicy: CachePolicy) -> Observable<[String : AnyObject]> {
        let URLPath = URL + apiPath
        return Alamofire.request(Method.POST, URLPath.URLString, parameters: parameters, encoding: ParameterEncoding.JSON, headers: HTTPHeader).rx_responseJSON(cancelOnDispose: true)
    }
}

// MARK: - decompose
extension BaseNetworkDataTaskProtocol {
    func decomposeJSONObjectToDictionary(JSONObject: [String : AnyObject]) -> ([String : AnyObject]?, [String : AnyObject]?) {
        if JSONObject["returnInfo"]!["returnEnum"]! as! String == "Success" {
            return (JSONObject["jsonWSResponse"]! as? [String : AnyObject], nil)
        } else {
            return (nil, JSONObject["returnInfo"] as? [String : AnyObject])
        }
    }
    
    func decomposeJSONObjectToArray(JSONObject: [String: AnyObject]) -> ([AnyObject]?, [String : AnyObject]?) {
        if JSONObject["returnInfo"]!["returnEnum"]! as! String == "Success" {
            return (JSONObject["jsonWSResponse"]! as? [AnyObject], nil)
        } else {
            return (nil, JSONObject["returnInfo"] as? [String : AnyObject])
        }
    }
}


// MARK: - json -> model
extension BaseNetworkDataTaskProtocol {
    func mapJSONToObject<T: Decodable>(JSONData: AnyObject, type: T.Type) -> T.DecodedType? {
        return T.decode(JSON.parse(JSONData)).value
    }
    
    func mapJSONToObjectArray<T: Decodable>(JSONDataArray: [AnyObject], type: T.Type) -> [T.DecodedType] {
        return JSONDataArray.map {
            debugPrint($0)
            debugPrint(T.decode(JSON.parse($0)))
           return T.decode(JSON.parse($0)).value!
        }
    }
}


extension BaseNetworkUploadTaskProtocol {
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
    func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, multipartDataBlock: () -> Void, progress: Double, completionBlock: ServiceResponseBlock) {
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
    func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, multipartData: NSData, progress: Double, completionBlock: ServiceResponseBlock) {
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
    func startUploadTaskWithParameters(parameters: [String : AnyObject], apiPath: String, multipartFilePath: [NSURL], progress: Double, completionBlock: ServiceResponseBlock) {
        // Alamofire 上传 图片的方法
    }
}

extension BaseNetworkCacheProtocol {
    /*************************************缓存机制*****************************************/
    
    func requestWithParameters(parameters: [String : AnyObject]) {
        // 这里 如果是 通过 GET 方法 需要把参数传进来
        //        return path
    }
    func cacheForRequest(path: String) -> BaseNetworkCache {
        // 这里 通过 请求路径 读取 本地的缓存
        return BaseNetworkCache()
    }
}




/*************************************extension third party*****************************************/

// MARK: - Alamofire Request
extension Request {
    func rx_responseJSON(options: NSJSONReadingOptions = .AllowFragments, cancelOnDispose: Bool = false) -> Observable<[String : AnyObject]> {
        
        return Observable<[String : AnyObject]>.create { observer in
            
            self.responseJSON(options: options) { responseData in
                
                let result = responseData.result
                let response = responseData.response
                
                switch result {
                case .Success(let JSONObject):
                    if 200 ..< 300 ~= response?.statusCode ?? 0 {
                        observer.onNext(JSONObject as! [String : AnyObject])
                        observer.onCompleted()
                    } else {
                        observer.onError(NSError(domain: "HTTP statusCode 错误", code: response?.statusCode ?? -1, userInfo: nil))
                    }
                case .Failure(let error):
                    observer.onError(error)
                }
            }
            
            return AnonymousDisposable {
                if cancelOnDispose {
                    self.cancel()
                }
            }
        }
    }
    
    func rx_responseString(encoding: NSStringEncoding? = nil, cancelOnDispose: Bool = false) -> Observable<String> {
        
        return Observable<String>.create { observer -> Disposable in
            
            self.responseString(encoding: encoding) { responseData in
                
                let result = responseData.result
                let response = responseData.response
                
                switch result {
                case .Success(let string):
                    if 200 ..< 300 ~= response?.statusCode ?? 0 {
                        observer.onNext(string)
                        observer.onCompleted()
                    } else {
                        observer.onError(NSError(domain: "HTTP statusCode 错误", code: response?.statusCode ?? -1, userInfo: nil))
                    }
                case .Failure(let error):
                    observer.onError(error)
                }
            }
            
            return AnonymousDisposable {
                if cancelOnDispose {
                    self.cancel()
                }
            }
        }
    }
    
    func rx_progress() -> Observable<(Int64, Int64, Int64)> {
        
        return Observable<(Int64, Int64, Int64)>.create { observer in
            
            self.progress() { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                
                observer.onNext((bytesWritten, totalBytesWritten, totalBytesExpectedToWrite))
            }
            
            return AnonymousDisposable {
            }
        }
    }
}

// MARK: - RxSwift Observable
extension Observable {
    func mapJSONStringToDictionary() ->  Observable<[String : AnyObject]> {
        return map { JSONStringData in
            guard let  data = JSONStringData as? NSData else {
                throw BaseNetworkError.NoData
            }
            return try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String: AnyObject]
        }
    }
}

