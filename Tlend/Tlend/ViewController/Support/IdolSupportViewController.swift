//
//  IdolSupportViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 15..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import SnapKit

class IdolSupportViewController: UIViewController {
    
    lazy var underNaviView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Const.screenWidth, height: 88))
        view.backgroundColor = .white
        return view
    }()
    
    struct Const {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let defaultHeaderHeight: CGFloat = 320
        static let detailNavi: String = "DetailViewNavigationController"
    }

    enum Section: Int, CaseIterable {
        case info
        case items
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var headerView: IdolHeaderView = IdolHeaderView.loadFromXib()
    var banner: Banner?
    var supports: [Support] = []
    var starIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        
        loading(.start)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupUI() {
        setupTableView()
        
        self.view.addSubview(self.underNaviView)
        setNavigationWhenDidScroll(self.tableView, underNavi: self.underNaviView, completion: nil)
    }
    
    private func getData() {
        IdolService.shared.getSupportData(idolIdx: self.starIdx ?? 0) { [weak self] result in
            switch result {
            case .success(let data):
                self?.banner = data.banner
                self?.supports = data.support
                self?.updateHeader()
                self?.tableView.reloadData()
                self?.loading(.end)
            case .error(let error):
                print(error.localizedDescription)
                self?.loading(.end)
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

extension IdolSupportViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .info:
            return 1
        case .items:
            return supports.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .info:
            let cell = tableView.dequeue(IdolProductHeaderCellTableViewCell.self, for: indexPath)
            cell.configure(.support)
            return cell
        case .items:
            guard supports.count > indexPath.row else { return UITableViewCell() }
            let cell = tableView.dequeue(IdolItemTableViewCell.self, for: indexPath)
            cell.configure(type: .support, support: supports[indexPath.row])
            return cell
        }

    }
}

extension IdolSupportViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .items:
            let navigationController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: Const.detailNavi)
            guard let viewController = navigationController.children.first as? DetailInfoViewController else { return }
            viewController.detailType = .support
            viewController.starIdx = self.starIdx
            viewController.detailIdx = self.supports[indexPath.row].supportIdx
            self.present(navigationController, animated: true, completion: nil)
            
        default:
            break
        }
    }
}

extension IdolSupportViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        guard offset <= 0.0 else {
            setNavigationWhenDidScroll(self.tableView, underNavi: self.underNaviView, completion: nil)
            return
        }
        
        headerView.snp.remakeConstraints({ make in
            make.top.equalToSuperview().inset(min(offset, 0))
            make.bottom.leading.trailing.equalToSuperview()
        })
    }
}
