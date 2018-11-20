//
//  Int+Tlend.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 21..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation

extension Int {
    func getDecimalNumber() -> String? {
        let numberformatter = NumberFormatter()
        numberformatter.numberStyle = .decimal
        
        let number = NSNumber(value: self)
        return numberformatter.string(from: number)
    }
}
