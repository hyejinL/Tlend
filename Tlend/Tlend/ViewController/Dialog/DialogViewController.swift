//
//  DialogViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import SnapKit

class DialogViewController: UIViewController {
    
    struct Const {
        static let height: CGFloat = 311.0
        static let inset: CGFloat = 24.0
        static let backgroundColor: UIColor = .init(white: 0, alpha: 0.6)
    }
    
    let confirmAction: ((DialogViewController) -> Void)?
    let cancelAction: ((DialogViewController) -> Void)?
    
    let dialog: TDialogView = TDialogView.loadFromXib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(dialog)
        dialog.snp.makeConstraints { make in
            make.height.equalTo(Const.height)
            make.leading.trailing.equalToSuperview().inset(Const.inset)
            make.center.equalToSuperview()
        }
    }
    
    init(title: String,
         content: String,
         confirmAction: ((DialogViewController) -> Void)? = nil,
         cancelAction: ((DialogViewController) -> Void)? = nil) {
        self.confirmAction = confirmAction
        self.cancelAction = cancelAction
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.view.backgroundColor = Const.backgroundColor
        
        self.setupDialog(title: title, content: content)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDialog(title: String, content: String) {
        dialog.configure(title: title, content: content)
        dialog.confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        dialog.cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    @objc func didTapConfirm() {
        self.confirmAction?(self)
        defer {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func didTapCancel() {
        self.cancelAction?(self)
        defer {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
