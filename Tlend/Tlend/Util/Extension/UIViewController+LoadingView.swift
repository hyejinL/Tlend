//
//  UIViewController+LoadingView.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 21..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import UIKit

enum LoadingState {
    case start
    case end
    
    func loading() {
        switch self {
        case .start:
            CustomLoadingView.shared.isAnimating = true
        case .end:
            CustomLoadingView.shared.isAnimating = false
        }
    }
}

extension UIViewController {
    func loading(_ state: LoadingState) {
        state.loading()
    }
}
