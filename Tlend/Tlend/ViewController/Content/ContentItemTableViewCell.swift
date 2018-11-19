//
//  ContentItemTableViewCell.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class ContentItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ item: TlendItem) {
        itemImageView.kf.setImage(with: URL(string: item.imageKey))
        if let _ = item.rewardTitle {
            itemTitleLabel.text = item.rewardTitle
        } else if let _ = item.supportTitle {
            itemTitleLabel.text = item.supportTitle
        }
        usernameLabel.text = item.userNickname
    }
}
