//
//  ChoiceFundingViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class ChoiceFundingViewController: UIViewController {

    @IBOutlet weak var optionChoiceTableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet var tableViewTopConstraint: NSLayoutConstraint!
    
    var selectType: SelectType = .none
    var array: [String] = ["블랙", "화이트", "챠콜", "브라운"]
    var choiceArray: [String] = []
    
    struct Const {
        static let header: String = "CloseHeaderCell"
    }
    
    enum StartAction {
        case start
        case end
    }
    
    enum Section: Int, CaseIterable {
        case header
        case option
        case choiceOption
        case total
    }
    
    enum SelectType {
        case none
        case select
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.optionTableViewAnimation(.start)
        })
        optionChoiceTableView.reloadData()
        CATransaction.commit()
    }
    
    @IBAction func tapBackgroundView(_ sender: Any) {
        self.optionTableViewAnimation(.end) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func optionTableViewAnimation(_ type: StartAction, completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.15, animations: {
            switch type {
            case .start:
                self.tableViewTopConstraint.isActive = false
            case .end:
                self.tableViewTopConstraint.isActive = true
            }
            self.view.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }
    
    private func tableViewReloadAnimation(_ tableView: UITableView, indexPath: IndexPath) {
        let index = IndexPath(row: 0, section: Section.option.rawValue)
        guard let cell = tableView.cellForRow(at: index) as? ChoiceOptionTableViewCell else { return }
        let bottomViewHeight: CGFloat = choiceArray.count > 0 ? 0 : 32
        
        UIView.animate(withDuration: 0.15) {
            switch self.selectType {
            case .none:
                cell.optionView.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
            case .select:
                cell.optionView.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            self.tableViewHeight.constant = self.optionChoiceTableView.contentSize.height + bottomViewHeight
            print(self.optionChoiceTableView.contentSize.height)
            self.view.layoutIfNeeded()
        }
    }
}

extension ChoiceFundingViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.optionChoiceTableView.delegate = self; self.optionChoiceTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .header:
            self.optionTableViewAnimation(.end) {
                self.dismiss(animated: true, completion: nil)
            }
        case .option:
            if indexPath.row == 0 {
                switch selectType {
                case .none:
                    self.selectType = .select
                case .select:
                    self.selectType = .none
                }
            } else {
                self.selectType = .none
                self.choiceArray.append(self.array[indexPath.row-1])
            }
            self.optionChoiceTableView.reloadData()
            self.tableViewReloadAnimation(tableView, indexPath: indexPath)
            
        default:
            break
        }
        
    }
}

extension ChoiceFundingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if choiceArray.count == 0 {
            return 2
        }
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .option:
            switch selectType {
            case .none:
                return 1
            case .select:
                return array.count+1
            }
        case .choiceOption:
            return choiceArray.count
            
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.header) else { return UITableViewCell() }
            return cell
        case .option:
            guard indexPath.row != 0 else {
                let cell = tableView.dequeue(ChoiceOptionTableViewCell.self, for: indexPath)
                return cell
            }
            let cell = tableView.dequeue(OptionTableViewCell.self, for: indexPath)
            cell.optionLabel.text = array[indexPath.row-1]
            return cell
        case .choiceOption:
            let cell = tableView.dequeue(SelectedOptionTableViewCell.self, for: indexPath)
            cell.optionLabel.text = self.choiceArray[indexPath.row]
            return cell
        case .total:
            let cell = tableView.dequeue(TotalAmountTableViewCell.self, for: indexPath)
            return cell
        }
    }
}
