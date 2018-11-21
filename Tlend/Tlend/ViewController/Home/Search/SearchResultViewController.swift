//
//  SearchResultViewController.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 13..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchResultViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet var naviSearchBar: UISearchBar!
    
    var text: String?
    
    struct Style {
        static let widthRatio: CGFloat = UIScreen.main.bounds.width/375
        static let searchBarFrame: CGRect = CGRect(x: 0, y: 0, width: 294*Style.widthRatio, height: 21)
        
        static let oldCellLabelColor: UIColor = #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
        static let newCellLabelColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        static let backgroundColor: UIColor = .white
        static let bottomViewColor: UIColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        static let bottomViewHeight: CGFloat = 1.0
        static let titleFontSize: CGFloat = 15.0
        
        static let spacingSize: CGFloat = 0
        static let insetSize: CGFloat = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.barPagerInit()
    }
    
    private func setupUI() {
        setWhiteNavigationBar()
        
        self.naviSearchBar.frame = Style.searchBarFrame
        self.naviSearchBar.setImage(#imageLiteral(resourceName: "icSearch"), for: .search, state: .normal)
        self.naviSearchBar.setImage(UIImage(), for: .clear, state: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.naviSearchBar)
    }
    
    private func barPagerInit() {
        settings.style.buttonBarBackgroundColor = Style.backgroundColor
        settings.style.buttonBarItemBackgroundColor = Style.backgroundColor
        
        settings.style.selectedBarBackgroundColor = Style.bottomViewColor
        settings.style.buttonBarItemFont = .systemFont(ofSize: Style.titleFontSize)
        settings.style.selectedBarHeight = Style.bottomViewHeight
        
        settings.style.buttonBarMinimumLineSpacing = Style.spacingSize
        settings.style.buttonBarMinimumInteritemSpacing = Style.spacingSize
        settings.style.buttonBarItemLeftRightMargin = Style.spacingSize
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = Style.insetSize
        settings.style.buttonBarRightContentInset = Style.insetSize
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = Style.oldCellLabelColor
            newCell?.label.textColor = Style.newCellLabelColor
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let supportViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(ofType: SearchResultTableViewController.self)
        supportViewController.detailType = .support
        supportViewController.searchText = self.text
        let rewardViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(ofType: SearchResultTableViewController.self)
        rewardViewController.detailType = .reward
        rewardViewController.searchText = self.text
        
        return [supportViewController, rewardViewController]
    }
}
