//
//  ViewController.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/4.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import UIKit
import Mantle

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        loadData()
    }
}

extension ViewController {
    
    func loadData() {

        BRProvider.request(Network.GetNetworkData()) {(result) -> () in
            switch result {
            case let .Success(response):
                do {
                    debugPrint(String(data: response.data, encoding: NSUTF8StringEncoding)!)
                    let json: Dictionary? = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let _ = json {
//                        debugPrint(json)
                        let mdoel = try! MTLJSONAdapter.modelOfClass(ModelTop.self, fromJSONDictionary: json)
                        debugPrint(mdoel as! ModelTop)
                    }

                } catch let error as NSError {
                    debugPrint(error)
                }
            case let .Failure(error):
                print(error)
                break
            }
        }
    }
}