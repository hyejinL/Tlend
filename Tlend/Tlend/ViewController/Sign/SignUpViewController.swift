//
//  SignUpViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailBox: UIView!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var pwBox: UIView!
    @IBOutlet weak var pwcField: UITextField!
    @IBOutlet weak var pwcBox: UIView!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var nicknameBox: UIView!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var addressBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.setWhiteNavigationBar()
    }
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetBoxBorder()
        if textField.tag == 0 {
            emailBox.borderColor = .liliac
        } else if textField.tag == 1 {
            pwBox.borderColor = .liliac
        } else if textField.tag == 2 {
            pwcBox.borderColor = .liliac
        } else if textField.tag == 3 {
            nicknameBox.borderColor = .liliac
        } else if textField.tag == 4 {
            addressBox.borderColor = .liliac
        }
    }
    
    func resetBoxBorder() {
        emailBox.borderColor = .gray225
        pwBox.borderColor = .gray225
        pwcBox.borderColor = .gray225
        nicknameBox.borderColor = .gray225
        addressBox.borderColor = .gray225
    }
}
