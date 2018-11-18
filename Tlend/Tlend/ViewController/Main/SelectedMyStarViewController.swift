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
    
    private var myStarIndexArray: NSMutableArray = []
    
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
}

extension SelectedMyStarViewController: UICollectionViewDelegate {
    private func collectionViewInit() {
        self.selectedMyStarCollectionView.delegate = self; self.selectedMyStarCollectionView.dataSource = self
        
        self.selectedMyStarCollectionView.register(MyStarImageCollectionViewCell.self)
        
        self.selectedMyStarCollectionView.allowsSelection = true
        self.selectedMyStarCollectionView.allowsMultipleSelection = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .MyStarList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? MyStarImageCollectionViewCell else { return }
            
            if self.myStarIndexArray.count < 3 {
                cell.selectedCell()
                self.myStarIndexArray.add(indexPath)
            }
            
            self.setStartButtonEnable(selected: self.myStarIndexArray.count)
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }

        switch section {
        case .MyStarList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? MyStarImageCollectionViewCell else { return }
            
            cell.selectedCell()
            self.myStarIndexArray.remove(indexPath)
            
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
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch section {
        case .SearchHeader:
            let cell = collectionView.dequeue(SearchStarCollectionViewCell.self, for: indexPath)
            return cell
        case .MyStarList:
            let cell = collectionView.dequeue(MyStarImageCollectionViewCell.self, for: indexPath)
            cell.selectedCell()
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
