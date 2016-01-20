//
//  TestNetworkViewModel.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/20.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import Foundation
import RxSwift

class TestNetworkViewModel: BaseNetworkDataTaskProtocol {
    
    let disposeBag = DisposeBag()
    
    var model: AnyObject! {
        didSet {
            
        }
    }
    
    // PublishSubject 绑定 View 进行数据传输
    func getJson() {
        
        startDataTaskWithParameters(["jsonWSRequest" : "111"], apiPath: "/myHttpTest", cachePolicy: CachePolicy.None).subscribe { event in
            switch event {
            case .Next :
                let decomposedObject = self.decomposeJSONObjectToArray(event.element!)
                
                if  let _ = decomposedObject.0 {
                    if let arr = decomposedObject.0 {
                        let modelArray = self.mapJSONToObjectArray(arr, type: ModelBasic.self)
                        debugPrint(modelArray)
                    }
                } else {
                    print("error: --- 失败 \(decomposedObject.1!)")
                }
            case .Error :
                debugPrint("error: --- \(event)")
            case .Completed :
                debugPrint("complete ---")
            }
            }.addDisposableTo(disposeBag)
    }
}



