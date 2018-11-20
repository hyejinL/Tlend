//
//  SearchStarCollectionViewCell.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SearchStarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myStarSearchBar: UITextField!
    
    weak var delegate: SendDataViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    @IBAction func editTextFieldAction(_ sender: UITextField) {
        delegate?.sendData(data: String.self, sender.text ?? "")
    }
    
    private func setupUI() {
        
    }
}
