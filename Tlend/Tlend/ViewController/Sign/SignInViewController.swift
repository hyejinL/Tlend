//
//  SignInViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var idBoxView: UIView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet var pwBoxView: UIView!
    @IBOutlet weak var pwField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setWhiteNavigationBar()
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func touchUpSignUp(_ sender: Any) {
        let vc = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(ofType: SignUpViewController.self)
        let navi = UINavigationController(rootViewController: vc)
        self.present(navi, animated: true, completion: nil)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            idBoxView.borderColor = .liliac
            pwBoxView.borderColor = .gray225
        } else if textField.tag == 1 {
            idBoxView.borderColor = .gray225
            pwBoxView.borderColor = .liliac
        }
    }
}
