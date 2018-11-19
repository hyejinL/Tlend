//
//  IdolRewardViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import SnapKit

class IdolRewardViewController: UIViewController {
    
    struct Const {
        static let defaultHeaderHeight: CGFloat = 320
    }
    
    enum Section: Int, CaseIterable {
        case info
        case items
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var headerView: IdolHeaderView = IdolHeaderView.loadFromXib()
    var starIdx: Int?
    var banner: RewardBanner?
    var rewards: [Reward] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func getData() {
        IdolService.shared.getRewardData(idolIdx: starIdx ?? 0) { [weak self] result in
            switch result {
            case .success(let data):
                self?.banner = data.banner
                self?.rewards = data.reward
                self?.tableView.reloadData()
                self?.updateHeader()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(IdolItemTableViewCell.self)
        tableView.register(IdolProductHeaderCellTableViewCell.self)
        let backgroundView = UIView(frame: .init(x: 0,
                                                 y: 0,
                                                 width: UIScreen.main.bounds.width,
                                                 height: Const.defaultHeaderHeight))
        backgroundView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.tableHeaderView = backgroundView
    }
    
    private func updateHeader() {
        guard let banner = banner else { return }
        headerView.configure(banner.bannerImage)
    }
    
    @IBAction func touchUpClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension IdolRewardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .info:
            return 1
        case .items:
            return rewards.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .info:
            let cell = tableView.dequeue(IdolProductHeaderCellTableViewCell.self, for: indexPath)
            cell.configure(.reward)
            return cell
        case .items:
            guard rewards.count > indexPath.row else { return UITableViewCell() }
            let cell = tableView.dequeue(IdolItemTableViewCell.self, for: indexPath)
            cell.configure(type: .reward, reward: rewards[indexPath.row])
            return cell
        }
        
    }
}

extension IdolRewardViewController: UITableViewDelegate {
}

extension IdolRewardViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        guard offset <= 0.0 else {
            return
        }
        
        headerView.snp.remakeConstraints({ make in
            make.top.equalToSuperview().inset(min(offset, 0))
            make.bottom.leading.trailing.equalToSuperview()
        })
    }
}
