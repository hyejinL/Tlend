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
    
    var detailType: DetailType?
    var buttonType: DetailInfoType = .detail
    lazy var infoHeaderView: InfoMenuHeaderView = .loadFromXib()
    
    var starIdx: Int?
    var detailIdx: Int?
    var common: CommonType?
    var detailData: ItemImage?
    var defaultData: ItemDefault?
    
    enum Section: Int, CaseIterable {
        case Header
        case ShareAndSaveButton
        case FundingProgress
        case Info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.tableViewInit()
        
        self.setupData()
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        if let navi = self.parent as? UINavigationController {
            navi.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupUI() {
        setWhiteNavigationBar()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupData() {
        guard let type = self.detailType else { return }
        let service = DetailService.shared
        
        switch type {
        case .support:
            service.getSupportDetail(self.starIdx ?? 0, detailIdx: self.detailIdx ?? 0) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.common = data.common
                    self?.detailData = data.itemDetail
                    self?.defaultData = data.itemDefault
                    self?.detailTableView.reloadData()
                case .error(let err):
                    print(err.localizedDescription)
                }
            }
        case .reward:
            service.getRewardDetail(self.starIdx ?? 0, detailIdx: self.detailIdx ?? 0) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.common = data.common
                    self?.detailData = data.itemDetail
                    self?.defaultData = data.itemDefault
                    self?.detailTableView.reloadData()
                case .error(let err):
                    print(err.localizedDescription)
                }
            }
            
        }
    }
}

extension DetailInfoViewController: SendDataViewControllerDelegate {
    func sendData<T>(data type: T.Type, _ data: T) {
        if let data = data as? DetailInfoType {
            self.buttonType = data
            
            self.detailTableView.beginUpdates()
            self.detailTableView.reloadRows(at: [.init(row: 0, section: Section.Info.rawValue)], with: .none)
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
        self.detailTableView.register(DetailSupportInfoTableViewCell.self)
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
            cell.configure(self.common?.itemImages ?? [])
            return cell
        case .ShareAndSaveButton:
            let cell = tableView.dequeue(ShareAndSaveButtonTableViewCell.self, for: indexPath)
            return cell
        case .FundingProgress:
            let cell = tableView.dequeue(FundingInfoTableViewCell.self, for: indexPath)
            return cell
        case .Info:
            switch buttonType {
            case .detail:
                let cell = tableView.dequeue(DetailInfoImageTableViewCell.self, for: indexPath)
                cell.configure(self.detailData?.imageKey ?? "")
                return cell
            case .default:
                guard let detailType = self.detailType else { return UITableViewCell() }
                switch detailType {
                case .support:
                    guard let data = self.defaultData as? SupportDefault else { return UITableViewCell() }
                    let cell = tableView.dequeue(DetailSupportInfoTableViewCell.self, for: indexPath)
                    cell.configure(data)
                    return cell
                case .reward:
                    guard let data = self.defaultData as? RewardDefault else { return UITableViewCell() }
                    let cell = tableView.dequeue(DetailInfoTableViewCell.self, for: indexPath)
                    cell.configure(data)
                    return cell
                }
            }
        }
    }
}
