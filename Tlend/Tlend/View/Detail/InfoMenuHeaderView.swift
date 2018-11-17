//
//  InfoMenuButtonTableViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

protocol SendDataViewControllerDelegate: class {
    func sendData<T>(data type: T.Type, _ data: T)
}

class InfoMenuHeaderView: UIView {

    @IBOutlet weak var detailInfoButton: UIButton!
    @IBOutlet weak var detailInfoBottomView: UIView!
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var infoBottomView: UIView!
    
    weak var delegate: SendDataViewControllerDelegate?
    var type: ButtonType = .Detail
    
    enum ButtonType {
        case Detail
        case Info
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.infoButtonAction(.Detail)
    }
    
    @IBAction func pressedDetailInfoAction(_ sender: Any) {
        guard self.type != .Detail else { return }
        self.infoButtonAction(.Detail)
    }
    
    @IBAction func pressedInfoAction(_ sender: Any) {
        guard self.type != .Info else { return }
        self.infoButtonAction(.Info)
    }
    
    private func infoButtonAction(_ type: ButtonType) {
        self.type = type
        switch type {
        case .Detail:
            self.detailInfoButton.isSelected = true
            self.infoButton.isSelected = false
        case .Info:
            self.detailInfoButton.isSelected = false
            self.infoButton.isSelected = true
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch type {
            case .Detail:
                self?.detailInfoBottomView.alpha = 1
                self?.infoBottomView.alpha = 0
                
            case .Info:
                self?.detailInfoBottomView.alpha = 0
                self?.infoBottomView.alpha = 1
            }
        }
        
        delegate?.sendData(data: ButtonType.self, type)
    }
    
}
