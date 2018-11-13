//
//  HomeMainViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 11..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class HomeMainViewController: UIViewController {
    
    @IBOutlet weak var homeMainTableView: UITableView!
    
    enum HomeItems: Int, CaseIterable {
        case HotKeyword
        case FundingItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.tableViewInit()
    }
    
    @IBAction func goSearchViewAction(_ sender: Any) {
        goSearchView()
    }
    
    private func setupUI() {
        setWhiteNavigationBar()
        setNavigationLogoTitle()
    }
    
}

extension HomeMainViewController: HotKeywordDelegate {
    func hotKeywordCellClickAction() {
        let viewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(ofType: HomeHotKeywordViewController.self)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeMainViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.homeMainTableView.delegate = self; self.homeMainTableView.dataSource = self
        
        self.homeMainTableView.register(HotKeywordTableViewCell.self)
        self.homeMainTableView.register(HomeItemsTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension HomeMainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeItems(rawValue: section) else { return 0 }
        
        switch section {
        case .HotKeyword:
            return 1
            
        case .FundingItems:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeItems(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .HotKeyword:
            let cell = tableView.dequeue(HotKeywordTableViewCell.self, for: indexPath)
            cell.delegate = self
            return cell
            
        case .FundingItems:
            let cell = tableView.dequeue(HomeItemsTableViewCell.self, for: indexPath)
            return cell
        }
    }
}
