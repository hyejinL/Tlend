//
//  IdolProductHeaderCellTableViewCell.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class IdolProductHeaderCellTableViewCell: UITableViewCell {
    
    enum ScreenType: String {
        case reward = "리워드"
        case support = "서포트"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var screenType: ScreenType = .reward

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ type: ScreenType) {
        titleLabel.text = type.rawValue
    }
}
