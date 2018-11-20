//
//  DetailHeaderImageCollectionViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class DetailHeaderImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headerImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(_ data: ItemImage) {
        self.headerImageVIew.kf.setImage(with: URL(string: data.imageKey))
    }
}
