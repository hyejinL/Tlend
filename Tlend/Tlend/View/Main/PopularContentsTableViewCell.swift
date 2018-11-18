//
//  PopularContentsTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class PopularContentsTableViewCell: UITableViewCell {

    @IBOutlet weak var popularContentsImageView: UIImageView!
    @IBOutlet weak var popularContentsTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
