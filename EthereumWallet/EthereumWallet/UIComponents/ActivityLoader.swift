//
//  ActivityLoader.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import UIKit

class ActivityLoader {
    static let shared = ActivityLoader()
    private var activityIndicator: UIActivityIndicatorView?
    
    private init() {}
    
    func showActivityIndicator(in view: UIView) {
        DispatchQueue.main.async {
            if self.activityIndicator == nil {
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.color = .white
                activityIndicator.center = view.center
                activityIndicator.hidesWhenStopped = true
                view.addSubview(activityIndicator)
                self.activityIndicator = activityIndicator
            }
            self.activityIndicator?.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.removeFromSuperview()
            self.activityIndicator = nil
        }
    }
}
