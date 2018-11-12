//
//  HotKeywordCollectionViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 12..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class HotKeywordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hotKeywordImageView: UIImageView!
    @IBOutlet weak var hotKeywordTitleLabel: UILabel!
    
    struct Const {
        static let imageShadowOpacity: Float = 0.16
        static let imageShadowSize: CGSize = CGSize(width: 0, height: 3)
        static let imageShadowBlur: CGFloat = 3
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.hotKeywordImageView.makeShadow(opacity: Const.imageShadowOpacity,
                                            size: Const.imageShadowSize,
                                            blur: Const.imageShadowBlur)
    }

}
