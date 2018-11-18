//
//  IdolHeaderView.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 15..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import Kingfisher

class IdolHeaderView: UIView {
    
    @IBOutlet weak var idolImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(_ imageURL: String) {
        self.idolImageView.kf.setImage(with: URL(string: imageURL))
    }
    
}
