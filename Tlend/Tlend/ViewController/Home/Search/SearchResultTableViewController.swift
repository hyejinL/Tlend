//
//  SearchResultTableViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 21..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchResultTableViewController: UIViewController {
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var detailType: DetailType?
    var searchText: String?
    
    var supports: [Support] = []
    var rewards: [Reward] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewInit()
        
        self.setupData()
    }
    
    private func setupData() {
        guard let type = self.detailType else { return }
        switch type {
        case .support:
            self.getSupportResult()
        case .reward:
            self.getRewardResult()
        }
    }
    
    private func getSupportResult() {
        SearchService.shared.searchSupportGoods(.support, text: self.searchText ?? "") { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.supports = data.itemList
                self?.searchResultTableView.reloadData()
            case .error(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func getRewardResult() {
        SearchService.shared.searchRewardGoods(.reward, text: self.searchText ?? "") { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.rewards = data.itemList
                self?.searchResultTableView.reloadData()
            case .error(let err):
                print(err.localizedDescription)
            }
        }
    }
}

extension SearchResultTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard let type = self.detailType else { return IndicatorInfo(title: "") }
        switch type {
        case .support:
            return IndicatorInfo(title: "서포트")
        case .reward:
            return IndicatorInfo(title: "리워드")
        }
    }
}

extension SearchResultTableViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.searchResultTableView.delegate = self; self.searchResultTableView.dataSource = self
        
        self.searchResultTableView.register(IdolItemTableViewCell.self)
    }
}

extension SearchResultTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let type = self.detailType else { return 0 }
        switch type {
        case .support:
            return self.supports.count
        case .reward:
            return self.rewards.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = self.detailType else { return UITableViewCell() }
        switch type {
        case .support:
            let cell = tableView.dequeue(IdolItemTableViewCell.self, for: indexPath)
            cell.configure(type: .support, support: supports[indexPath.row])
            return cell
        case .reward:
            let cell = tableView.dequeue(IdolItemTableViewCell.self, for: indexPath)
            cell.configure(type: .reward, reward: rewards[indexPath.row])
            return cell
        }
    }
}
