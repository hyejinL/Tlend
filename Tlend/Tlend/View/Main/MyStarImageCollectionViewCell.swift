//
//  MyStarImageCollectionViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 15..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class MyStarImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var starImageView: CircleImageView!
    @IBOutlet weak var starChoiceImageView: CircleView!
    @IBOutlet weak var starNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.starImageView.layoutIfNeeded()
//        self.starImageView.roundCorner()
//        self.starChoiceImageView.roundCorner()
        
        self.starChoiceImageView.alpha = 0
        
        self.starNameLabel.text = "블랙핑크"
    }
    
    public func selectedCell() {
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let `self` = self else { return }
            
            switch self.isSelected {
            case true:
                self.starChoiceImageView.alpha = 1
            case false:
                self.starChoiceImageView.alpha = 0
            }
            
        }
    }
}
