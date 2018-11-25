//
//  DialogView.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class TDialogView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var typeImageView: UIImageView!
    
    enum DialogType {
        case warning
        case check
        
        var image: UIImage {
            switch self {
            case .warning:
                return #imageLiteral(resourceName: "11.png")
            case .check:
                return #imageLiteral(resourceName: "path5.png")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ type: DialogType = .check, title: String, content: String) {
        self.typeImageView.image = type.image
        self.titleLabel.text = title
        self.contentLabel.setLineHeightMultiple(to: 1.2, withAttributedText: content)
    }

}
