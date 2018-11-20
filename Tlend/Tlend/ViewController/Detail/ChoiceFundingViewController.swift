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
    
    @IBOutlet weak var tableHiddenView: UIView!
    
    var selectType: SelectType = .none
    var array: [String] = []
    var choiceArray: [String] = []
    
    struct Const {
        static let header: String = "CloseHeaderCell"
        static let navigation: String = "FundingEndNavi"
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
    
    enum DialogStartType {
        case end
        case start
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
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
    
    @IBAction func startFundingAction(_ sender: Any) {
        if self.choiceArray.count > 0 {
            self.tableHiddenViewAnimation(.start)
            
            let text = """
            펀딩 시 결제가 예약되며
            목표금액 미달성 시 결제가 취소되고
            달성 시 상품 마감일에 일괄 결제 됩니다.
            """
            guard let presentingViewController = self.presentingViewController else { return }
            let dialogViewController = DialogViewController(title: "잠깐", content: text, confirmAction: { (dialog) in
                dialog.dismiss(animated: false, completion: {
                    self.dismiss(animated: false, completion: {
                        let navigationController = UIStoryboard(name: "Detail", bundle: nil)
                            .instantiateViewController(withIdentifier: Const.navigation)
                        presentingViewController.present(navigationController, animated: true, completion: nil)
                    })
                })
            }) { [weak self] (_) in
                self?.tableHiddenViewAnimation(.end)
            }
            self.present(dialogViewController, animated: true, completion: nil)
        }
    }
    
    private func setupUI() {
        self.tableHiddenView.alpha = 0
        self.tableHiddenView.isHidden = true
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
        
        UIView.animate(withDuration: 0.15) {
            switch self.selectType {
            case .none:
                cell.optionView.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
            case .select:
                cell.optionView.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        updateHeight()
    }
    
    private func updateHeight() {
        UIView.animate(withDuration: 0.15) {
            let bottomViewHeight: CGFloat = self.choiceArray.count > 0 ? 0 : 32
            self.tableViewHeight.constant = self.optionChoiceTableView.contentSize.height + bottomViewHeight
            print(self.optionChoiceTableView.contentSize.height)
            self.view.layoutIfNeeded()
        }
    }
    
    private func tableHiddenViewAnimation(_ type: DialogStartType) {
        switch type {
        case .end:
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.tableHiddenView.alpha = 0
            }) { [weak self] (_) in
                self?.tableHiddenView.isHidden = true
            }
        case .start:
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.tableHiddenView.alpha = 1
            }) { [weak self] (_) in
                self?.tableHiddenView.isHidden = false
            }
        }
    }
}

extension ChoiceFundingViewController: UITableViewDelegate {
    private func tableViewInit() {
        self.optionChoiceTableView.delegate = self; self.optionChoiceTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.updateHeight()
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
