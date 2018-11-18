//
//  SplashCollectionViewCell.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SplashCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configure(data: SplashData) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        contentImageView.image = data.image
    }
}
