//
//  HotKeywordTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 12..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class HotKeywordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotKeywordCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionViewInit()
    }
}

extension HotKeywordTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    private func collectionViewInit() {
        self.hotKeywordCollectionView.delegate = self; self.hotKeywordCollectionView.dataSource = self
        
        let nib = UINib(nibName: "HotKeywordCollectionViewCell", bundle: nil)
        self.hotKeywordCollectionView.register(nib, forCellWithReuseIdentifier: "HotKeywordCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotKeywordCollectionViewCell", for: indexPath) as? HotKeywordCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension HotKeywordTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize = CGSize(width: 120, height: 145)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spacing: CGFloat = 15
        return spacing
    }
}
