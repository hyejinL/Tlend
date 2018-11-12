//
//  UIView+Shadow.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 12..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import UIKit

protocol ShadowView {
    var shadowColor: UIColor? { set get }
    
}

extension UIView {
    func makeShadow(_ color: UIColor = UIColor.black,
                    opacity: Float = 1,
                    size offset: CGSize,
                    blur radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
}
