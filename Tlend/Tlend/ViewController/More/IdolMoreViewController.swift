//
//  IdolMoreViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class IdolMoreViewController: UIViewController {
    
    enum Item: Int, CaseIterable {
        case introduce
        case schedule
        case search
        case member
        
        var title: String {
            switch self {
            case .introduce:
                return "그룹 소개"
            case .schedule:
                return "스케줄"
            case .search:
                return "실시간 검색어"
            case .member:
                return "멤버"
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setWhiteNavigationBar()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    @IBAction func touchUpClose(_ sender: Any) {
        self.dismiss(animated: true
            , completion: nil)
    }
    
}

extension IdolMoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Item.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = Item(rawValue: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeue(MoreTableViewCell.self, for: indexPath)
        cell.configure(title: item.title)
        return cell
    }
}

extension IdolMoreViewController: UITableViewDelegate {
    
}
