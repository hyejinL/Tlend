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
    
    enum Section: Int, CaseIterable {
        case MyStarList
        case TrendRaking
        case PopularContents
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.tableViewInit()
    }

    private func setupUI() {
        setWhiteNavigationBar()
        setNavigationLogoTitle()
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
            let tabbarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
            self.present(tabbarController, animated: true, completion: nil)
            
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
            return 3
        case .TrendRaking:
            return 5
        case .PopularContents:
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        guard indexPath.row != 0 else {
            let cell = tableView.dequeue(MyStarHomeTitleTableViewCell.self, for: indexPath)
            cell.titleLabel.text = "내새끼"
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
            return cell
        case .TrendRaking:
            let cell = tableView.dequeue(TrendRankingTableViewCell.self, for: indexPath)
            
            if indexPath.row == 3 {
                cell.bottomView.isHidden = true
            }
            
            return cell
        case .PopularContents:
            let cell = tableView.dequeue(PopularContentsTableViewCell.self, for: indexPath)
            cell.popularContentsTitleLabel.text = "BTS가 빌보드를 뒤집어 놓으셨다!"
            return cell
        }
    }
}
