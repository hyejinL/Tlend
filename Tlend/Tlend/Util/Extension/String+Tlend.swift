//
//  String+Tlend.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 23..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

extension String {
    func validateEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
