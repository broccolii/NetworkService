//
//  ViewController.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/4.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import UIKit

class TestNetworkViewController: UIViewController {
    
    let testNetworkViewModel = TestNetworkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        testNetworkViewModel.getJson()
    }
}
