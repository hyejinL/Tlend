//
//  MyStarFeedTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class MyStarFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedTitleLabel: UILabel!
    @IBOutlet weak var feedContentsLabel: UILabel!
    
    var mediaIdx: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(_ data: Media) {
        self.mediaIdx = data.mediaIdx
        self.feedImageView.kf.setImage(with: URL(string: data.imageKey),
                                       options: [.transition(.fade(0.3))])
        self.feedTitleLabel.text = data.mediaTitle
    }
    
}
