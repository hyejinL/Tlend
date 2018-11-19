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
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: ContentImageProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ imageURL: String) {
        contentImageView.kf.setImage(with: URL(string: imageURL)) { [weak self] (image, _, _, _) in
            guard let image = image else { return }
            let ratio = image.size.height / image.size.width
            
            DispatchQueue.main.async {
                self?.imageHeightConstraint.constant = UIScreen.main.bounds.size.width * ratio
                self?.layoutIfNeeded()
                self?.delegate?.setImageHeight()
            }
        }
    }

}
