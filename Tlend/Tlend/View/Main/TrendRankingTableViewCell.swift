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
    
    var starIdx: Int?
    var popularType: [PopularType] = [.up, .up, .line, .up, .line, .line, .line]
    
    enum PopularType: String {
        case up = "▴"
        case line = "-"
        case down = "▾"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(_ data: Idol, index: Int) {
        self.starIdx = data.idolIdx
        self.trendStarLabel.text = data.idolName
        self.changeRankingViewLabel.text = popularType[index].rawValue
        if popularType[index] == .up {
            self.changeRankingViewLabel.textColor = #colorLiteral(red: 0.8980392157, green: 0.4431372549, blue: 0.4431372549, alpha: 1)
        }
    }
    
}
