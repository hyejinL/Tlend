//
//  HotKeywordHeaderTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 12..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class HotKeywordHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var hotKeywordImageView: UIImageView!
    
    @IBOutlet weak var hotKeywordTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var hotKeywordProbabilityLabel: UILabel!
    @IBOutlet weak var hotKeywordPeriodLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
