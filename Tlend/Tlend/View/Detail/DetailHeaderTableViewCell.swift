//
//  DetailHeaderTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var detailImageCollectionView: UICollectionView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    var images: [ItemImage] = []
    
    struct Style {
        static let widthRatio: CGFloat = UIScreen.main.bounds.width/375
        
        static let cellSize: CGSize = CGSize(width: 375*Style.widthRatio, height: 380*Style.widthRatio)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionViewInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(_ data: [ItemImage]) {
        self.images = data
        self.detailImageCollectionView.reloadData()
    }
}

extension DetailHeaderTableViewCell: UICollectionViewDelegate {
    private func collectionViewInit() {
        self.detailImageCollectionView.delegate = self; self.detailImageCollectionView.dataSource = self
        
        self.detailImageCollectionView.register(DetailHeaderImageCollectionViewCell.self)
    }
}

extension DetailHeaderTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(DetailHeaderImageCollectionViewCell.self, for: indexPath)
        return cell
    }
}

extension DetailHeaderTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Style.cellSize
    }
}
