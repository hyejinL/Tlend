//
//  SignUpViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 17..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

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
    @IBOutlet weak var signUpBottomConstraint: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.setWhiteNavigationBar()
        RxKeyboard.instance.visibleHeight.drive(onNext: { [weak self] height in
            guard let `self` = self else { return }
            
            let const = height - self.view.safeAreaInsets.bottom
            self.signUpBottomConstraint.constant = const > 0 ? const : 0
            self.view.layoutIfNeeded()
        }).disposed(by: disposeBag)
        
        let gesture = UITapGestureRecognizer()
        self.view.addGestureRecognizer(gesture)
        
        gesture.rx.event.asDriver().drive(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapSignUp(_ sender: Any) {
        guard !(self.emailField.text?.isEmpty ?? true),
            !(self.pwField.text?.isEmpty ?? true),
            !(self.pwcField.text?.isEmpty ?? true),
            !(self.nicknameField.text?.isEmpty ?? true)
            else { return }
        SignService.shared.signUp(id: emailField.text ?? "",
                                  pw: pwField.text ?? "",
                                  nickname: nicknameField.text ?? "",
                                  completion: { [weak self] _ in
                                    let dialog = DialogViewController(title: "가입이 완료되었습니다",
                                                                      content: "트렌드를 이용하기 위해 내새끼를 선택해주세요!",
                                                                      confirmAction: { [weak self] dialog in
                                                                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectStarNavigation")
                                                                        dialog.dismiss(animated: true, completion: { [weak self] in
                                                                            self?.present(vc, animated: true, completion: nil)
                                                                        })
                                    })
                                    dialog.dialog.cancelButton.removeFromSuperview()
                                    self?.present(dialog, animated: true, completion: nil)
                                    })
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resetBoxBorder()
    }
    
    func resetBoxBorder() {
        emailBox.borderColor = .gray225
        pwBox.borderColor = .gray225
        pwcBox.borderColor = .gray225
        nicknameBox.borderColor = .gray225
        addressBox.borderColor = .gray225
    }
}
