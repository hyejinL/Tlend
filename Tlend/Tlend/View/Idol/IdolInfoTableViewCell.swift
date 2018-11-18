//
//  IdolInfoTableViewCell.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 15..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class IdolInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
