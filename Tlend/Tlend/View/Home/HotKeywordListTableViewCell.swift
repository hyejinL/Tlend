//
//  HotKeywordListTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 13..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class HotKeywordListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var hotKeywordImageView: UIImageView!
    
    @IBOutlet weak var hotKeywordTitleLabel: UILabel!
    @IBOutlet weak var hotKeywordCompanyLabel: UILabel!
    @IBOutlet weak var hotKeywordProbabilityLabel: UILabel!
    @IBOutlet weak var hotKeywordPeriodLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
