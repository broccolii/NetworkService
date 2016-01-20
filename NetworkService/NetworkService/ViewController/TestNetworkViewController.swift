//
//  ViewController.swift
//  NetworkService
//
//  Created by Broccoli on 16/1/4.
//  Copyright © 2016年 Broccoli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestNetworkViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let testNetworkViewModel = TestNetworkViewModel()
    var tableViewDataArr = [ModelBasic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testNetworkViewModel.getJson()
    }
}

// MARK: - UITableViewDataSource
private let CellIdentifier = "TestNetworkViewCell"
extension TestNetworkViewController {
    func bindtoTableView() {
        testNetworkViewModel.tableViewData.asObservable().bindTo(tableView.rx_itemsWithCellIdentifier(CellIdentifier)) {(row, element, cell) in
            guard let myCell: UITableViewCell = cell else {
                return
            }
            myCell.textLabel?.text = "\(element.date)"
            myCell.detailTextLabel?.text = "\(element.s)"
            }.addDisposableTo(disposeBag)
    }
}