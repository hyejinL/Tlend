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
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    weak var delegate: ContentImageProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ data: String) {
        self.detailInfoImageView.kf.setImage(with: URL(string: data)) { [weak self] (image, _, _, _) in
            guard let image = image else { return }
            let ratio = image.size.height / image.size.width
            let height = UIScreen.main.bounds.size.width * ratio
            if self?.imageViewHeight.constant ?? 0 != height {
                self?.imageViewHeight.constant = height
                self?.delegate?.setImageHeight()
            }
        }
    }
    
}
