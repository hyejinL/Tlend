//
//  IdolItemTableViewCell.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 15..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class IdolItemTableViewCell: UITableViewCell {

    enum ItemType {
        case support
        case reward
    }
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemKeywordView: UIView!
    @IBOutlet weak var itemKeywordLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(type: ItemType) {
        switch type {
        case .support:
            itemKeywordView.backgroundColor = .support
            percentLabel.textColor = .support
            itemKeywordLabel.text = "서포트"
        case .reward:
            itemKeywordView.backgroundColor = .reward
            percentLabel.textColor = .reward
            itemKeywordLabel.text = "리워드"
        }
    }
}
