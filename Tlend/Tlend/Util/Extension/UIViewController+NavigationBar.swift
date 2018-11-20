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
    
    func goSearchView() {
        guard let navigationController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchNavigation") as? UINavigationController else { return }
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // View controller-based status bar appearance
    func setNavigationWhenDidScroll(_ scrollView: UIScrollView,
                                    underNavi view: UIView,
                                    completion: ((CGPoint) -> Void)?) {
        let offset = scrollView.contentOffset
        guard offset.y >= 20 else {
            view.isHidden = true
            UIApplication.shared.statusBarStyle = .lightContent
            return
        }
        let ratio: CGFloat = (300-offset.y)/300
        view.isHidden = false
        view.alpha = 1.0-ratio
        
        if offset.y > 300 {
            UIApplication.shared.statusBarStyle = .default
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }
        setNeedsStatusBarAppearanceUpdate()
        
        let color: CGFloat = ratio*255
//        guard color >= 0 else {
//            color = 0
//            return
//        }
        let buttonColor = UIColor(red: color, green: color, blue: color, alpha: 1.0)
        
        if let buttons = self.navigationItem.leftBarButtonItems {
            for button in buttons {
                button.tintColor = buttonColor
            }
        }
        if let buttons = self.navigationItem.rightBarButtonItems {
            for button in buttons {
                button.tintColor = buttonColor
            }
        }
        
        completion?(offset)
    }
}
