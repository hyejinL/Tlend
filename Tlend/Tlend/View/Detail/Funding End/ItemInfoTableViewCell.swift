//
//  ItemInfoTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 20..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class ItemInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(title: String?, options: [String]) {
        self.titleLabel.text = title
        
        var optionList = ""
        for (index, option) in options.enumerated() {
            if index != 0 {
                optionList += ", "
            }
            optionList += option
        }
        self.optionsLabel.text = "옵션 : " + optionList
        
        let formatter = DateFormatter()
        formatter.dateFormat = "주문일시 : yyyy년 MM월 dd일"
        self.dateLabel.text = formatter.string(from: Date())
    }
}
