//
//  IdolHeaderView.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 15..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import Kingfisher

class IdolHeaderView: UIView {
    
    @IBOutlet weak var idolImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.idolImageView.kf.setImage(with: URL(string:"https://www.grammy.com/sites/com/files/styles/news_detail_header/public/gettyimages-877192122.jpg?itok=gW_QMOgT"))
    }
}
