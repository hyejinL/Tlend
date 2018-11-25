//
//  String+Tlend.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 23..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func validateEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func setSpacing(lineSpacing: CGFloat) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: self)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        style.minimumLineHeight = lineSpacing
        style.alignment = .center
        
        // Line spacing attribute
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value: style,
                                range: NSRange(location: 0, length: self.count))
        
        // Character spacing attribute
        attrString.addAttribute(NSAttributedString.Key.kern,
                                value: 1,
                                range: NSMakeRange(0, attrString.length))
        
        return attrString
    }
}
