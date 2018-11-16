//
//  SearchStarCollectionViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SearchStarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myStarSearchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    private func setupUI() {
    }
}
