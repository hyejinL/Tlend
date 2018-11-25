//
//  FundingInfoTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class FundingInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var currentBillingLabel: UILabel!
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var percentViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var remainDateLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    struct Const {
        static let percentViewFirstWidth: CGFloat = UIScreen.main.bounds.width - 40
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(type: DetailType?, _ data: CommonType?) {
        guard let type = type, let data = data else { return }
        
        self.currentBillingLabel.text = (data.currentMoney?.getDecimalNumber() ?? "0") + " 원 모집"
        self.percentLabel.text = "\(data.percent)%"
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.percentViewWidth.constant = Const.percentViewFirstWidth * CGFloat(data.percent > 100 ? 100 : data.percent)/100
            self?.layoutIfNeeded()
        }
        
        self.remainDateLabel.text = "\(data.dDay)일 남음"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일에 \(type.text)예정"
        self.dueDateLabel.text = formatter.string(from: data.schedule)
    }
    
}
