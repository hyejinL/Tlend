//
//  HomeMainViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 11..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class HomeMainViewController: UIViewController {
    
    @IBOutlet weak var homeMainTableView: UITableView!
    
    lazy var underNaviView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: Style.screenWidth,
                                        height: 44 + UIApplication.shared.statusBarFrame.height))
        view.backgroundColor = .white
        return view
    }()
    
    lazy var headerView: IdolHeaderView = IdolHeaderView.loadFromXib()
    
    public var starIdx: Int?
    private var myBaby: Idol?
    private var member: [IdolMember] = []
    private var media: [Media] = []
    
    struct Style {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let defaultHeaderHeight: CGFloat = 350
    }
    
    enum Section: Int, CaseIterable {
        case info
        case member
        case items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.tableViewInit()
        
        self.setupData()
        
        loading(.start)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func setupUI() {
        self.view.addSubview(underNaviView)
        setWhiteNavigationBar()
        setNavigationWhenDidScroll(self.homeMainTableView, underNavi: self.underNaviView, completion: nil)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupData() {
        HomeService.shared.getIdolHomeData(self.starIdx ?? 0) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.headerView.configure(data.idolGroup.groupTitleImg ?? "")
                self?.myBaby = data.idolGroup
                self?.member = data.idolMember
                self?.media = data.media
                self?.homeMainTableView.reloadData()
                self?.loading(.end)
            case .error(let err):
                print(err.localizedDescription)
                self?.loading(.end)
            }
        }
    }
    @IBAction func touchUpClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension HomeMainViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.homeMainTableView.delegate = self
        self.homeMainTableView.dataSource = self
        
        self.homeMainTableView.tableFooterView = UIView(frame: .zero)
        self.homeMainTableView.register(IdolInfoTableViewCell.self)
        self.homeMainTableView.register(MyStarMemberListTableViewCell.self)
        self.homeMainTableView.register(MyStarFeedTableViewCell.self)
        self.homeMainTableView.register(MyStarHomeTitleTableViewCell.self)
        let backgroundView = UIView(frame: .init(x: 0,
                                                 y: 0,
                                                 width: UIScreen.main.bounds.width,
                                                 height: Style.defaultHeaderHeight))
        backgroundView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.homeMainTableView.tableHeaderView = backgroundView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .items:
            guard indexPath.row > 0 else { return }
            let vc = UIStoryboard(name: "Content", bundle: nil).instantiateViewController(ofType: ContentDetailViewController.self)
            vc.mediaID = self.media[indexPath.row - 1].mediaIdx
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }

    }
}

extension HomeMainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .info:
            return 1
        case .member:
            return 1
        case .items:
            return self.media.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .info:
            let cell = tableView.dequeue(IdolInfoTableViewCell.self, for: indexPath)
            if cell.bottomView != nil {
                cell.bottomView.removeFromSuperview()
            }
            if let idol = self.myBaby {
                cell.configure(idol)
            }
            return cell
        case .member:
            let cell = tableView.dequeue(MyStarMemberListTableViewCell.self, for: indexPath)
            cell.configure(self.member)
            return cell
        case .items:
            guard indexPath.row != 0 else {
                let cell = tableView.dequeue(MyStarHomeTitleTableViewCell.self, for: indexPath)
                cell.titleLabel.text = "피드"
                return cell
            }
            
            let cell = tableView.dequeue(MyStarFeedTableViewCell.self, for: indexPath)
            cell.configure(self.media[indexPath.row - 1])
            return cell
        }
    }
}

extension HomeMainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        guard offset <= 0.0 else {
            setNavigationWhenDidScroll(scrollView, underNavi: self.underNaviView, completion: nil)
            return
        }
        
        headerView.snp.remakeConstraints({ make in
            make.top.equalToSuperview().inset(min(offset, 0))
            make.bottom.leading.trailing.equalToSuperview()
        })
    }
}
