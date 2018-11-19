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
    
    var idx: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(type: ItemType, support: Support? = nil, reward: Reward? = nil) {
        switch type {
        case .support:
            itemKeywordView.backgroundColor = .support
            percentLabel.textColor = .support
            itemKeywordLabel.text = "서포트"
            
            guard let support = support else { return }
            idx = support.supportIdx
            itemImageView.kf.setImage(with: URL(string: support.imageKey))
            titleLabel.text = support.supportTitle
            usernameLabel.text = support.userNickname
            percentLabel.text = "\(support.percent)%"
            dayLabel.text = "\(support.dDay)일 남음"
        case .reward:
            itemKeywordView.backgroundColor = .reward
            percentLabel.textColor = .reward
            itemKeywordLabel.text = "리워드"
            
            guard let reward = reward else { return }
            idx = reward.rewardIdx
            itemImageView.kf.setImage(with: URL(string: reward.imageKey))
            titleLabel.text = reward.rewardTitle
            usernameLabel.text = reward.userNickname
            percentLabel.text = "\(reward.percent)%"
            dayLabel.text = "\(reward.dDay)일 남음"
        }
    }
}
