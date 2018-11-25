//
//  SelectedMyStarViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import RxSwift
import RxKeyboard

class SelectedMyStarViewController: UIViewController {

    @IBOutlet weak var selectedMyStarCollectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var idols: [Idol] = []
    var collectionIdols: [Idol] = []
    private var myStarIndexArray: Set<IndexPath> = []
    private var myStarNames: Set<String> = []
    
    let disposeBag = DisposeBag()
    
    struct Style {
        static let widthRatio: CGFloat = UIScreen.main.bounds.width/375
        
        static let headerSize: CGSize = CGSize(width: 375*Style.widthRatio, height: 50)
        
        static let cellSize: CGSize = CGSize(width: 135*Style.widthRatio, height: 167*Style.widthRatio)
        static let cellEdgeInset: UIEdgeInsets = UIEdgeInsets(top: 27*Style.widthRatio,
                                                              left: 35*Style.widthRatio,
                                                              bottom: 27*Style.widthRatio,
                                                              right: 35*Style.widthRatio)
    }
    
    enum Section: Int, CaseIterable {
        case SearchHeader
        case MyStarList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.collectionViewInit()
        setupData()
        
    }
    
    private func setupData() {
        SignService.shared.getIdols { [weak self] result in
            switch result {
            case .success(let data):
                self?.idols = data.idol
                self?.collectionIdols = self?.idols ?? []
                self?.selectedMyStarCollectionView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        setWhiteNavigationBar()
        
        self.setStartButtonEnable(selected: self.myStarIndexArray.count)
        
        RxKeyboard.instance.visibleHeight.drive(onNext: { [weak self] height in
            guard let `self` = self else { return }
            
            let const = height - self.view.safeAreaInsets.bottom
            self.buttonBottomConstraint.constant = const > 0 ? const : 0
            self.view.layoutIfNeeded()
        }).disposed(by: disposeBag)
        
        self.selectedMyStarCollectionView.backgroundView = UIView()
        let gesture = UITapGestureRecognizer()
        self.selectedMyStarCollectionView.backgroundView?.addGestureRecognizer(gesture)
        
        gesture.rx.event.asDriver().drive(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    
    private func setStartButtonEnable(selected count: Int) {
        switch count > 0 {
        case true:
            self.startButton.isEnabled = true
            self.startButton.backgroundColor = #colorLiteral(red: 0.7851700783, green: 0.5716921091, blue: 1, alpha: 1)
        case false:
            self.startButton.isEnabled = false
            self.startButton.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
        }
        
        self.startButton.setTitle("시작하기 (\(count)/3)", for: .normal)
    }
    @IBAction func touchUpStart(_ sender: Any) {
        loading(.start)
        SignService.shared.sendMyStar(idolNames: self.myStarNames) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.loading(.end)
                print(self?.myStarNames)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyStarNavigation")
                self?.present(vc, animated: true, completion: nil)
            case .error(let err):
                print(err.localizedDescription)
            }
        }
    }
}

extension SelectedMyStarViewController: SendDataViewControllerDelegate {
    func sendData<T>(data type: T.Type, _ data: T) {
        if let data = data as? String {
            if data.isEmpty {
                self.collectionIdols = self.idols
            } else {
                let result = self.idols.filter { $0.idolName.range(of: data) != nil }
                self.collectionIdols = result
            }
            self.selectedMyStarCollectionView.reloadSections(IndexSet(integer: 1))
            
            guard self.selectedMyStarCollectionView.numberOfItems(inSection: 1) > 0 else { return }
            for (index, item) in self.collectionIdols.enumerated() {
                if self.myStarNames.contains(item.idolName) {
                    self.selectedMyStarCollectionView.selectItem(at: IndexPath(item: index, section: 1),
                                                                 animated: true,
                                                                 scrollPosition: .top)
                }
            }
        }
    }
}

extension SelectedMyStarViewController: UICollectionViewDelegate {
    private func collectionViewInit() {
        self.selectedMyStarCollectionView.delegate = self; self.selectedMyStarCollectionView.dataSource = self
        
        self.selectedMyStarCollectionView.register(MyStarImageCollectionViewCell.self)
        
        self.selectedMyStarCollectionView.allowsSelection = true
        self.selectedMyStarCollectionView.allowsMultipleSelection = true
        self.selectedMyStarCollectionView.keyboardDismissMode = .onDrag
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .MyStarList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? MyStarImageCollectionViewCell else { return }
            
            if self.myStarNames.count < 3 {
                print(self.myStarNames)
                cell.selectedCell(true)
                self.myStarIndexArray.insert(indexPath)
                self.myStarNames.insert(self.collectionIdols[indexPath.row].idolName)
            }
            
            self.setStartButtonEnable(selected: self.myStarNames.count)
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }

        switch section {
        case .MyStarList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? MyStarImageCollectionViewCell else { return }
            cell.selectedCell(false)
            self.myStarIndexArray.remove(indexPath)
            self.myStarNames.remove(self.collectionIdols[indexPath.row].idolName)
            
            self.setStartButtonEnable(selected: self.myStarNames
                .count)

        default:
            break
        }
    }
}

extension SelectedMyStarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .SearchHeader:
            return 1
        case .MyStarList:
            return collectionIdols.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch section {
        case .SearchHeader:
            let cell = collectionView.dequeue(SearchStarCollectionViewCell.self, for: indexPath)
            cell.delegate = self
            return cell
        case .MyStarList:
            guard collectionIdols.count > indexPath.item else { return UICollectionViewCell() }
            let cell = collectionView.dequeue(MyStarImageCollectionViewCell.self, for: indexPath)
            cell.configure(type: .idol, idol: collectionIdols[indexPath.item])
//            if self.myStarIndexArray.contains(indexPath) {
////                cell.isSelected = true
//                cell.selectedCell(true)
//            } else {
//                cell.selectedCell(false)
//            }
            if self.myStarNames.filter({ $0 == self.collectionIdols[indexPath.item].idolName }).count > 0 {
                cell.selectedCell(true)
            } else {
                cell.selectedCell(false)
            }
            return cell
        }
    }
}

extension SelectedMyStarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else { return CGSize.zero }
        
        switch section {
        case .SearchHeader:
            return Style.headerSize
        case .MyStarList:
            return Style.cellSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = Section(rawValue: section) else { return UIEdgeInsets.zero }
        
        switch section {
        case .MyStarList:
            return Style.cellEdgeInset
            
        default:
            return UIEdgeInsets.zero
        }
    }
}
