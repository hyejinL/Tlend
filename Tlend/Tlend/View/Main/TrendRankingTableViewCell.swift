//
//  TrendRankingTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class TrendRankingTableViewCell: UITableViewCell {

    @IBOutlet weak var trendRankingLabel: UILabel!
    @IBOutlet weak var trendStarLabel: UILabel!
    @IBOutlet weak var changeRankingViewLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
