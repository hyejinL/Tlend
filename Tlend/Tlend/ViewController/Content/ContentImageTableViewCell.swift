//
//  ContentImageTableViewCell.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

protocol ContentImageProtocol: class {
    func setImageHeight()
}

class ContentImageTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    
    weak var delegate: ContentImageProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ imageURL: String) {
        contentImageView.kf.setImage(with: URL(string: imageURL)) { [weak self] (_, _, _, _) in
            self?.delegate?.setImageHeight()
        }
    }

}
