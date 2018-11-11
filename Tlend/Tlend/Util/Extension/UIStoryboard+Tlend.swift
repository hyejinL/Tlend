//
//  UIStoryboard+Tlend.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 11..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
