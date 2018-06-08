//
//  ViewControllerExtension.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/8.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertWithConfirmTitle(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Confirm", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoading(show: Bool) {
        if show {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = "Loading..."
            
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

