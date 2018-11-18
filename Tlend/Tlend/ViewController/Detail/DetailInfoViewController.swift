//
//  DetailInfoViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    
    var buttonType: InfoMenuHeaderView.ButtonType = .Detail
    lazy var infoHeaderView: InfoMenuHeaderView = .loadFromXib()
    
    enum Section: Int, CaseIterable {
        case Header
        case ShareAndSaveButton
        case FundingProgress
        case Info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewInit()
    }
    
}

extension DetailInfoViewController: SendDataViewControllerDelegate {
    func sendData<T>(data type: T.Type, _ data: T) {
        if let data = data as? InfoMenuHeaderView.ButtonType {
            self.buttonType = data
            
            self.detailTableView.beginUpdates()
            self.detailTableView.endUpdates()
            self.detailTableView.layer.removeAllAnimations()
        }
    }
}

extension DetailInfoViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.detailTableView.delegate = self; self.detailTableView.dataSource = self
        
        self.detailTableView.register(DetailHeaderTableViewCell.self)
        self.detailTableView.register(ShareAndSaveButtonTableViewCell.self)
        self.detailTableView.register(FundingInfoTableViewCell.self)
        self.detailTableView.register(DetailInfoTableViewCell.self)
        self.detailTableView.register(DetailInfoImageTableViewCell.self)
    }
}

extension DetailInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = Section(rawValue: section) else { return UITableViewCell() }
        
        if section == .Info {
            let view = infoHeaderView
            view.delegate = self
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = Section(rawValue: section) else { return 0 }
        
        if section == .Info {
            return 48.0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Header:
            let cell = tableView.dequeue(DetailHeaderTableViewCell.self, for: indexPath)
            return cell
        case .ShareAndSaveButton:
            let cell = tableView.dequeue(ShareAndSaveButtonTableViewCell.self, for: indexPath)
            return cell
        case .FundingProgress:
            let cell = tableView.dequeue(FundingInfoTableViewCell.self, for: indexPath)
            return cell
        case .Info:
            switch buttonType {
            case .Detail:
                let cell = tableView.dequeue(DetailInfoImageTableViewCell.self, for: indexPath)
                return cell
            case .Info:
                let cell = tableView.dequeue(DetailInfoTableViewCell.self, for: indexPath)
                return cell
            }
        }
    }
}
