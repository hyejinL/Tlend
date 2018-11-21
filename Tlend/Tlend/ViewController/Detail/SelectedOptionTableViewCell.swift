//
//  SelectedOptionTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SelectedOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionCountLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    weak var delegate: SendDataViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func pressedPlusAction(_ sender: Any) {
        let count = Int(self.optionCountLabel.text ?? "1") ?? 1
        self.optionCountLabel.text = "\(count+1)"
        
        delegate?.sendData(data: Int.self, 1)
    }
    
    @IBAction func pressedMinusAction(_ sender: Any) {
        let count = Int(self.optionCountLabel.text ?? "1") ?? 1
        if count > 1 {
            self.optionCountLabel.text = "\(count-1)"
            delegate?.sendData(data: Int.self, -1)
        }
    }
    
    @IBAction func removeAction(_ sender: Any) {
        delegate?.sendData(data: String.self, "remove")
    }
}
