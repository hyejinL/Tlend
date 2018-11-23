//
//  SearchViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 13..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var naviSearchBar: UISearchBar!
    @IBOutlet weak var suggestionTableView: UITableView!
    @IBOutlet var suggestionTableHeaderView: UIView!
    
    var searchArray: [String] = ["비투비", "피규어", "육성재", "승리"]
    
    struct Style {
        static let widthRatio: CGFloat = UIScreen.main.bounds.width/375
        static let searchBarFrame: CGRect = CGRect(x: 0, y: 0, width: 294*Style.widthRatio, height: 21)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.searchBarInit()
        self.tableViewInit()
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        setWhiteNavigationBar()
        
        self.naviSearchBar.frame = Style.searchBarFrame
        self.naviSearchBar.setImage(#imageLiteral(resourceName: "icSearch"), for: .search, state: .normal)
        self.naviSearchBar.setImage(UIImage(), for: .clear, state: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.naviSearchBar)
        
        self.naviSearchBar.becomeFirstResponder()
    }
}

extension SearchViewController: UISearchBarDelegate {
    private func searchBarInit() {
        self.naviSearchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let viewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(ofType: SearchResultViewController.self)
        viewController.text = self.naviSearchBar.text
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.suggestionTableView.delegate = self; self.suggestionTableView.dataSource = self
        
        self.suggestionTableView.tableFooterView = UIView(frame: .zero)
        
        self.suggestionTableView.register(FormCheckTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FormCheckTableViewCell else { return }
        
        cell.setSelected(false, animated: false)
        cell.setNeedsDisplay()
        
        self.naviSearchBar.text = cell.titleLabel.text
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.suggestionTableHeaderView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FormCheckTableViewCell.self, for: indexPath)
        cell.configure(self.searchArray[indexPath.row])
        return cell
    }
}
