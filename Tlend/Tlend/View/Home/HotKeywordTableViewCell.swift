//
//  HotKeywordTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 12..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

protocol HotKeywordDelegate: class {
    func hotKeywordCellClickAction()
}

class HotKeywordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotKeywordCollectionView: UICollectionView!
    
    struct Const {
        static let cellSize: CGSize = CGSize(width: 120, height: 145)
        static let cellInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let cellSpacing: CGFloat = 15
    }
    
    weak var delegate: HotKeywordDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionViewInit()
    }
}

extension HotKeywordTableViewCell: UICollectionViewDelegate {
    private func collectionViewInit() {
        self.hotKeywordCollectionView.delegate = self; self.hotKeywordCollectionView.dataSource = self
        
        self.hotKeywordCollectionView.register(HotKeywordCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let action = delegate?.hotKeywordCellClickAction else { return }
        action()
    }
}

extension HotKeywordTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(HotKeywordCollectionViewCell.self, for: indexPath)
        
        return cell
    }
}

extension HotKeywordTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Const.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Const.cellInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Const.cellSpacing
    }
}
