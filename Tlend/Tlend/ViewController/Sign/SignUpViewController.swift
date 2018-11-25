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
    @IBOutlet weak var emailErrorMessage: UILabel!
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
    
    enum ConfirmEmailMessage: String {
        case confirm = "사용가능한 id입니다"
        case failure = "이미 사용중인 id입니다."
        
        func confirmAction(_ label: UILabel) {
            switch self {
            case .confirm:
                label.isHidden = true
            case .failure:
                label.isHidden = false
                label.text = "중복된 이메일이 있습니다!"
            }
        }
        
        var confirm: Bool {
            switch self {
            case .confirm:
                return true
            case .failure:
                return false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    @IBAction func editingEmailField(_ sender: Any) {
        if !(self.emailField.text?.validateEmail() ?? true) {
            self.emailErrorMessage.isHidden = false
            self.emailErrorMessage.text = "올바른 이메일 형식으로 작성해주세요 :("
        } else {
            self.emailErrorMessage.isHidden = true
        }
    }
    
    @IBAction func endEditingEmailField(_ sender: UITextField) {
        if sender.tag == 0 &&
            (self.emailField.text?.validateEmail() ?? true) {
            self.confirmID()
        }
    }
    
    private func setupUI() {
        self.setWhiteNavigationBar()
        self.emailErrorMessage.isHidden = true
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
    
    private func confirmID(completion: ((ConfirmEmailMessage) -> Void)? = nil) {
        SignService.shared.confirmID(email: self.emailField.text ?? "") { (result) in
            switch result {
            case .success(let msg):
                guard let confirm = ConfirmEmailMessage(rawValue: msg) else {
                    print(msg)
                    return
                }
                confirm.confirmAction(self.emailErrorMessage)
                completion?(confirm)
            case .error(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSignUp(_ sender: Any) {
        self.signUp()
    }
    
    private func signUp() {
        guard !(self.emailField.text?.isEmpty ?? true),
            !(self.pwField.text?.isEmpty ?? true),
            !(self.pwcField.text?.isEmpty ?? true),
            !(self.nicknameField.text?.isEmpty ?? true),
            (self.emailErrorMessage.isHidden)
            else { return }
        confirmID { [weak self] (confirm) in
            if confirm.confirm {
                SignService.shared.signUp(id: self?.emailField.text ?? "",
                                          pw: self?.pwField.text ?? "",
                                          nickname: self?.nicknameField.text ?? "",
                                          completion: { [weak self] result in
                                            switch result {
                                            case .success(let data):
                                                try? AuthService.shared.saveToken("\(data.userIDX)")
                                                let dialog = DialogViewController(.check,
                                                                                  title: "가입이 완료되었습니다",
                                                                                  content: "트렌드를 이용하기 위해\n내새끼를 선택해주세요!",
                                                                                  confirmAction: { [weak self] dialog in
                                                                                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectStarNavigation")
                                                                                    dialog.dismiss(animated: true, completion: { [weak self] in
                                                                                        self?.present(vc, animated: true, completion: nil)
                                                                                    })
                                                })
                                                dialog.dialog.cancelButton.removeFromSuperview()
                                                self?.present(dialog, animated: true, completion: nil)
                                            case .error(let err):
                                                print(err.localizedDescription)
                                            }
                })
            }
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            pwField.becomeFirstResponder()
        } else if textField.tag == 1 {
            pwcField.becomeFirstResponder()
        } else if textField.tag == 2 {
            nicknameField.becomeFirstResponder()
        } else if textField.tag == 3 {
            self.signUp()
        }
        return true
    }
    
    func resetBoxBorder() {
        emailBox.borderColor = .gray225
        pwBox.borderColor = .gray225
        pwcBox.borderColor = .gray225
        nicknameBox.borderColor = .gray225
        addressBox.borderColor = .gray225
    }
}
