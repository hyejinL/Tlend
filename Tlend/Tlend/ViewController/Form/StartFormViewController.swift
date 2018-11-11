//
//  StartFormViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 11..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class StartFormViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func touchUpNextButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Form", bundle: nil)
            .instantiateViewController(ofType: FundingKindViewController.self)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
