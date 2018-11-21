//
//  SelectedMyStarViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SelectedMyStarViewController: UIViewController {

    @IBOutlet weak var selectedMyStarCollectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    
    var idols: [Idol] = []
    var collectionIdols: [Idol] = []
    private var myStarIndexArray: Set<IndexPath> = []
    private var myStarNames: Set<String> = []
    
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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyStarNavigation")
        self.present(vc, animated: true, completion: nil)
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
                                                                 scrollPosition: .centeredVertically)
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(111)
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .MyStarList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? MyStarImageCollectionViewCell else { return }
            
            if self.myStarIndexArray.count < 3 {
                cell.selectedCell(true)
                self.myStarIndexArray.insert(indexPath)
                self.myStarNames.insert(self.collectionIdols[indexPath.row].idolName)
            }
            
            self.setStartButtonEnable(selected: self.myStarIndexArray.count)
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(22)
        guard let section = Section(rawValue: indexPath.section) else { return }

        switch section {
        case .MyStarList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? MyStarImageCollectionViewCell else { return }
            cell.selectedCell(false)
            self.myStarIndexArray.remove(indexPath)
            self.myStarNames.remove(self.collectionIdols[indexPath.row].idolName)
            
            self.setStartButtonEnable(selected: self.myStarIndexArray.count)

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
