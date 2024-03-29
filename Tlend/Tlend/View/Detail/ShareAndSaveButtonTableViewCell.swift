//
//  ShareAndSaveButtonTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class ShareAndSaveButtonTableViewCell: UITableViewCell {
    
    weak var delegate: SendDataViewControllerDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressedShareAction(_ sender: Any) {
        delegate?.sendData(data: String.self, "share")
    }
}
