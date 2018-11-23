//
//  SignInViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 16..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import RxKeyboard
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    @IBOutlet weak var idBoxView: UIView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet var pwBoxView: UIView!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var loginBottomConstraint: NSLayoutConstraint!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setWhiteNavigationBar()
        
        RxKeyboard.instance.visibleHeight.drive(onNext: { [weak self] height in
            guard let `self` = self else { return }
            
            let const = -(height - self.view.safeAreaInsets.bottom)
            self.loginBottomConstraint.constant = const < 0 ? const : 0
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
    @IBAction func touchUpSignUp(_ sender: Any) {
        let vc = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(ofType: SignUpViewController.self)
        let navi = UINavigationController(rootViewController: vc)
        self.present(navi, animated: true, completion: nil)
    }
    @IBAction func touchUpSignIn(_ sender: Any) {
        guard !(idField.text?.isEmpty ?? true),
            !(pwField.text?.isEmpty ?? true) else { return }
        loading(.start)
        SignService.shared.signIn(id: idField.text ?? "",
                                  pw: pwField.text ?? "") { [weak self] result in
                                    switch result {
                                    case .success(let data):
                                        self?.loading(.end)
                                        print(data.userIDX)
                                        try? AuthService.shared.saveToken("\(data.userIDX)")
                                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyStarNavigation")
                                        self?.present(vc, animated: true, completion: nil)
                                    case .error(let error):
                                        print(error.localizedDescription)
                                    }
        }
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        pwBoxView.borderColor = .gray225
        idBoxView.borderColor = .gray225
    }
}
