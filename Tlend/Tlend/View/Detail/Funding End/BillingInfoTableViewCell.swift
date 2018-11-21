//
//  BillingInfoTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 20..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class BillingInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveryPriceLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(price: Int, total: Int) {
        self.priceLabel.text = (price.getDecimalNumber() ?? "") + "원"
        self.totalAmountLabel.text = (total.getDecimalNumber() ?? "") + "원"
    }
    
}
