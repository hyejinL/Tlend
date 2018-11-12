//
//  UIViewController+NavigationBar.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 12..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setWhiteNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setNavigationLogoTitle() {
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo"))
    }
}
