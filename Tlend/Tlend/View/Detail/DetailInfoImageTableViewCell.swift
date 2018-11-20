//
//  DetailInfoImageTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class DetailInfoImageTableViewCell: UITableViewCell {

    @IBOutlet weak var detailInfoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ data: String) {
        self.detailInfoImageView.kf.setImage(with: URL(string: data))
    }
    
}
