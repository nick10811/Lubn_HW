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
    
    let viewModel = AuthViewModel()
    
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func clickSignIn(_ sender: Any) {
        let emailString = emailTextField.text ?? ""
        let pwdString = pwdTextField.text ?? ""
        
        self.showLoading(show: true)
        viewModel.siginIn(email: emailString, pwd: pwdString, completion: {
            self.showLoading(show: false)
            let vc = findViewControllerByIdFromStoryboard("Main", viewControllerId: "PropertyViewController") as! PropertyViewController
            self.present(vc, animated: true, completion: nil)
            
        }) { (code, message) in
            self.showLoading(show: false)
            self.showAlertWithConfirmTitle(title: "Error(\(code))", message: message)
        }
    }
    
    @IBAction func clickSignUp(_ sender: Any) {
        guard let url = URL(string: viewModel.getURL(type: .register)) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func clickForgotPwd(_ sender: Any) {
        guard let url = URL(string: viewModel.getURL(type: .resetPwd)) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
