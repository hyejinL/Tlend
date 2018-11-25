//
//  CustomLoadingView.swift
//  Tlend
//
//  Created by 이혜진 on 2018. 11. 21..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class CustomLoadingView {
    static let shared = CustomLoadingView()
    
    private var containerView = UIView()
    private var progressView = UIView()
    private var activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    public var isAnimating: Bool = false {
        didSet {
            switch self.isAnimating {
            case true:
                self.startLoading()
            case false:
                self.stopLoading()
            }
        }
    }
    
    open func startLoading() {
        guard let view = UIApplication.shared.keyWindow else { return }
        
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = view.center
        progressView.backgroundColor = .white
        progressView.clipsToBounds = true
        progressView.cornerRadius = 10
//        progressView.layer.shadowColor = UIColor.black.cgColor
//        progressView.layer.shadowOffset = CGSize.zero
//        progressView.layer.shadowOpacity = 1
//        progressView.layer.shadowRadius = 10
//        progressView.layer.cornerRadius = 10
        
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2,
                                           y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    open func stopLoading() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
}
