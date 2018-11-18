//
//  LandingViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func touchUpLogin(_ sender: Any) {
        let vc = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(ofType: SignInViewController.self)
        let navi = UINavigationController(rootViewController: vc)
        present(navi, animated: true, completion: nil)
    }
}
