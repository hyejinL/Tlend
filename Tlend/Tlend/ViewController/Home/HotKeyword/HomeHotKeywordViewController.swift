//
//  HomeHotKeywordViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 11..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class HomeHotKeywordViewController: UIViewController {

    @IBOutlet weak var homeHotKeywordTableView: UITableView!
    
    enum HotKeywordList: Int, CaseIterable {
        case Header
        case List
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewInit()
    }
    
}

extension HomeHotKeywordViewController: UITableViewDelegate, UITableViewDataSource {
    private func tableViewInit() {
        self.homeHotKeywordTableView.delegate = self; self.homeHotKeywordTableView.dataSource = self
        
        self.homeHotKeywordTableView.register(HotKeywordListTableViewCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HotKeywordList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HotKeywordList(rawValue: section) else { return 0 }
        
        switch section {
        case .Header:
            return 1
        case .List:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HotKeywordList(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Header:
            let cell = tableView.dequeue(HotKeywordHeaderTableViewCell.self, for: indexPath)
            return cell
        case .List:
            let cell = tableView.dequeue(HotKeywordListTableViewCell.self, for: indexPath
            )
            return cell
        }
    }
}
