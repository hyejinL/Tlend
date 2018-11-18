//
//  CircleView.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import UIKit

class CircleImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundCorner()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorner()
    }
}

class CircleView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundCorner()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorner()
    }
}
