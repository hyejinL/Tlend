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
    
    struct Const {
        static let detailNavi: String = "DetailViewNavigationController"
    }
    
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
                switch err {
                case ErrorMessage.errorMessage(let message):
                    print(message)
                default:
                    break
                }
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
                switch err {
                case ErrorMessage.errorMessage(let message):
                    print(message)
                default:
                    break
                }
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
        self.searchResultTableView.register(SearchEmptyViewTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = self.detailType else { return }
        
        let navigationController = UIStoryboard(name: "Detail", bundle: nil)
            .instantiateViewController(withIdentifier: Const.detailNavi)
        guard let viewController = navigationController.children
            .first as? DetailInfoViewController else { return }
        viewController.detailType = type
        
        switch type {
        case .support:
            guard supports.count > indexPath.row else { return }
            let support = supports[indexPath.row]
            viewController.starIdx = support.idolID
            viewController.detailIdx = support.index
        case .reward:
            guard rewards.count > indexPath.row else { return }
            let reward = rewards[indexPath.row]
            viewController.starIdx = reward.idolID
            viewController.detailIdx = reward.index
        }
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension SearchResultTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let type = self.detailType else { return 0 }
        switch type {
        case .support:
            return self.supports.count > 0 ? self.supports.count : 1
        case .reward:
            return self.rewards.count > 0 ? self.rewards.count : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = self.detailType else { return UITableViewCell() }
        switch type {
        case .support:
            print(supports)
            guard self.supports.count > 0 else {
                let cell = tableView.dequeue(SearchEmptyViewTableViewCell.self, for: indexPath)
                return cell
            }
            let cell = tableView.dequeue(IdolItemTableViewCell.self, for: indexPath)
            cell.configure(type: type, support: supports[indexPath.row])
            return cell
        case .reward:
            print(rewards)
            guard self.rewards.count > 0 else {
                let cell = tableView.dequeue(SearchEmptyViewTableViewCell.self, for: indexPath)
                return cell
            }
            let cell = tableView.dequeue(IdolItemTableViewCell.self, for: indexPath)
            cell.configure(type: type, reward: rewards[indexPath.row])
            return cell
        }
    }
}
