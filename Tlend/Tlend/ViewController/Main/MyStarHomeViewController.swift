//
//  MyStarHomeViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class MyStarHomeViewController: UIViewController {

    @IBOutlet weak var myStarTableView: UITableView!
    
    private var myBabies: [Idol] = []
    private var idolRanking: [Idol] = []
    private var media: [Media] = []
    
    struct Const {
        static let headerString: [String] = ["내새끼", "실시간 트랜드 랭킹", "인기 컨텐츠"]
    }
    
    enum Section: Int, CaseIterable {
        case MyStarList
        case TrendRaking
        case PopularContents
        
        var headerFooterCount: Int {
            switch self {
            case .MyStarList,
                 .TrendRaking:
                return 2
            case .PopularContents:
                return 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.tableViewInit()
        
        self.setupData()
    }

    private func setupUI() {
        setWhiteNavigationBar()
        setNavigationLogoTitle()
    }
    
    private func setupData() {
        HomeService.shared.getHomeData { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.myBabies = data.mybaby
                self?.idolRanking = data.idolName
                self?.media = data.media
                self?.myStarTableView.reloadData()
            case .error(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    
    private func goMainTabbar(_ starIdx: Int) {
        let tabbarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
        guard let navigationController = tabbarController.children.first as? UINavigationController,
        let viewController = navigationController.viewControllers.first as? HomeMainViewController,
        let navigationController2 = tabbarController.children[1] as? UINavigationController,
        let viewController2 = navigationController2.viewControllers.first as? IdolSupportViewController,
        let navigationController3 = tabbarController.children[2] as? UINavigationController,
        let viewController3 = navigationController3.viewControllers.first as? IdolRewardViewController else { return }
        viewController.starIdx = starIdx
        viewController2.starIdx = starIdx
        viewController3.starIdx = starIdx
        self.present(tabbarController, animated: true, completion: nil)
    }
}

extension MyStarHomeViewController: SendDataViewControllerDelegate {
    func sendData<T>(data type: T.Type, _ data: T) {
        if let data = data as? Int {
            self.goMainTabbar(data)
        }
    }
}

extension MyStarHomeViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.myStarTableView.delegate = self; self.myStarTableView.dataSource = self
        
        self.myStarTableView.register(MyStarHomeTitleTableViewCell.self)
        self.myStarTableView.register(MyStarHomeFooterTableViewCell.self)
        self.myStarTableView.register(MyStarListTableViewCell.self)
        self.myStarTableView.register(TrendRankingTableViewCell.self)
        self.myStarTableView.register(PopularContentsTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .TrendRaking:
            guard indexPath.row > 0 else { return }
            self.goMainTabbar(self.idolRanking[indexPath.row - 1].idolIdx)
        default:
            break
        }
    }
}

extension MyStarHomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .MyStarList:
            return 1 + section.headerFooterCount
        case .TrendRaking:
            return self.idolRanking.count + section.headerFooterCount
        case .PopularContents:
            return self.media.count + section.headerFooterCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        guard indexPath.row != 0 else {
            let cell = tableView.dequeue(MyStarHomeTitleTableViewCell.self, for: indexPath)
            cell.titleLabel.text = Const.headerString[indexPath.section]
            return cell
        }
        
        guard !((section == .MyStarList && indexPath.row == 2) ||
            (section == .TrendRaking && indexPath.row == 4)) else {
            let cell = tableView.dequeue(MyStarHomeFooterTableViewCell.self, for: indexPath)
            return cell
        }
        
        switch section {
        case .MyStarList:
            let cell = tableView.dequeue(MyStarListTableViewCell.self, for: indexPath)
            cell.sendDelegate = self
            cell.configure(self.myBabies)
            return cell
        case .TrendRaking:
            guard self.idolRanking.count > indexPath.row - 1 else { return UITableViewCell() }
            let cell = tableView.dequeue(TrendRankingTableViewCell.self, for: indexPath)
            cell.trendRankingLabel.text = "\(indexPath.row)"
            cell.configure(self.idolRanking[indexPath.row - 1], index: indexPath.row - 1)
            
            if indexPath.row == 3 {
                cell.bottomView.isHidden = true
            }
            
            return cell
        case .PopularContents:
            guard self.media.count > indexPath.row - 1 else { return UITableViewCell() }
            let cell = tableView.dequeue(PopularContentsTableViewCell.self, for: indexPath)
            cell.configure(self.media[indexPath.row - 1])
            return cell
        }
    }
}
