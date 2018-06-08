//
//  BaseViewController.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/8.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideStatusBar(hide: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideStatusBar(hide: Bool) {
        UIApplication.shared.isStatusBarHidden = hide
    }
    
}
