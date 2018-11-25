//
//  MyStarImageCollectionViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 15..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import Kingfisher

class MyStarImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var starImageView: CircleImageView!
    @IBOutlet weak var starChoiceImageView: CircleView!
    @IBOutlet weak var starNameLabel: UILabel!
    
    var starIdx: Int?
    
    enum DataType {
        case idol
        case member
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    private func setupUI() {
        self.starImageView.layoutIfNeeded()
        
        self.starChoiceImageView.alpha = 0
    }
    
    public func configure(type: DataType,
                          idol: Idol? = nil,
                          member: IdolMember? = nil) {
        switch type {
        case .idol:
            self.starIdx = idol?.idolIdx
            self.starNameLabel.text = idol?.idolName
            self.starImageView.kf.setImage(with: URL(string: idol?.imageKey ?? ""),
                                           options: [.transition(.fade(0.3))])
        case .member:
            self.starIdx = member?.memberIdx
            self.starNameLabel.text = member?.memberName
            self.starImageView.kf.setImage(with: URL(string: member?.memberImgKey ?? ""),
                                           options: [.transition(.fade(0.3))])
        }
    }
    
    public func selectedCell(_ selected: Bool) {
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let `self` = self else { return }
            
            switch selected {
            case true:
                self.starChoiceImageView.alpha = 1
            case false:
                self.starChoiceImageView.alpha = 0
            }
            
        }
    }
}
