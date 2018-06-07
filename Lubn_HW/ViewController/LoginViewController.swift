//
//  LoginViewController.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.attributedPlaceholder = emailTextField.placeholder?.getPlaceholderAttribute()
        pwdTextField.attributedPlaceholder = pwdTextField.placeholder?.getPlaceholderAttribute()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickSignIn(_ sender: Any) {
    }
    
    @IBAction func clickSignUp(_ sender: Any) {
    }
    
    @IBAction func clickForgotPwd(_ sender: Any) {
    }
}
