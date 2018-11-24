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

class InfoMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var detailInfoButton: UIButton!
    @IBOutlet weak var detailInfoBottomView: UIView!
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var infoBottomView: UIView!
    
    weak var delegate: SendDataViewControllerDelegate?
    var type: DetailInfoType = .detail
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.infoButtonAction(.detail)
    }
    
    @IBAction func pressedDetailInfoAction(_ sender: Any) {
        guard self.type != .detail else { return }
        self.infoButtonAction(.detail)
    }
    
    @IBAction func pressedInfoAction(_ sender: Any) {
        guard self.type != .default else { return }
        self.infoButtonAction(.default)
    }
    
    private func infoButtonAction(_ type: DetailInfoType) {
        self.type = type
        switch type {
        case .detail:
            self.detailInfoButton.isSelected = true
            self.infoButton.isSelected = false
        case .default:
            self.detailInfoButton.isSelected = false
            self.infoButton.isSelected = true
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch type {
            case .detail:
                self?.detailInfoBottomView.alpha = 1
                self?.infoBottomView.alpha = 0
                
            case .default:
                self?.detailInfoBottomView.alpha = 0
                self?.infoBottomView.alpha = 1
            }
        }
        
        delegate?.sendData(data: DetailInfoType.self, type)
    }
    
}
