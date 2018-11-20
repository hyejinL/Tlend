//
//  FinishFundingViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 20..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class FinishFundingViewController: UIViewController {

    @IBOutlet weak var finishFundingTableView: UITableView!
    
    enum Section: Int, CaseIterable {
        case item
        case buyer
        case billing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.tableViewInit()
    }
    
    @IBAction func pressedConfirmAction(_ sender: Any) {
        if let navi = self.parent {
            navi.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupUI() {
        setWhiteNavigationBar()
    }
}

extension FinishFundingViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.finishFundingTableView.delegate = self; self.finishFundingTableView.dataSource = self
        
        self.finishFundingTableView.register(ItemInfoTableViewCell.self)
        self.finishFundingTableView.register(BuyerInfoTableViewCell.self)
        self.finishFundingTableView.register(BillingInfoTableViewCell.self)
    }
}

extension FinishFundingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .item:
            let cell = tableView.dequeue(ItemInfoTableViewCell.self, for: indexPath)
            return cell
        case .buyer:
            let cell = tableView.dequeue(BuyerInfoTableViewCell.self, for: indexPath)
            return cell
        case .billing:
            let cell = tableView.dequeue(BillingInfoTableViewCell.self, for: indexPath)
            return cell
        }
    }
}
