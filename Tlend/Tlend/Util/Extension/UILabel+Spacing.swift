//
//  UILabel+Spacing.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 26..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLineHeightMultiple(to height: CGFloat, withAttributedText attributedText: String) {
        let attrString = NSMutableAttributedString(string: attributedText)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = height
        paragraphStyle.alignment = textAlignment
        
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length - 1))
        
        self.attributedText = attrString
    }
}
