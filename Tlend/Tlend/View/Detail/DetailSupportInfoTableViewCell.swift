//
//  DetailSupportInfoTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 20..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class DetailSupportInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var targetBillingLabel: UILabel!
    @IBOutlet weak var currentBillingLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var finishDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(_ data: SupportDefault) {
        self.nameLabel.text = data.title
        self.optionLabel.text = data.optionName + " 중 택 1"
        self.targetBillingLabel.text = (data.goalMoney?.getDecimalNumber() ?? "") + " 원"
        self.currentBillingLabel.text = (data.currentMoney?.getDecimalNumber() ?? "0") + " 원"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        self.dueDateLabel.text = formatter.string(from: data.schedule)
        self.startDateLabel.text = formatter.string(from: data.startDate ?? Date())
        self.finishDateLabel.text = formatter.string(from: data.finishDate ?? Date())
    }
}
