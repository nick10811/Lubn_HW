//
//  AuthViewModel.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/8.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import SDWebImage

enum URLType {
    case register
    case resetPwd
}

class AuthViewModel: BaseViewModel {
    
    func siginIn(email: String,
                 pwd: String,
                 completion:@escaping ()->Void,
                 error:@escaping (Int,String)->Void) {
        
        let webservice = LoginService(email: email, pwd: pwd)
        _ = webservice.login(respnose: { (token, managerInfo, propertyCount, propertyArray) in
            // store user data
            let user = UserManager.sharedInstance()
            user.jwtToken = token
            user.managerInfo = managerInfo
            user.propertyCount = propertyCount
            user.addPropertyArray(array: propertyArray)
            completion()
        }, error: { (code, message) in
            var newMessage = message
            if code == NetworkError.unauthorized.rawValue {
                newMessage = "Incorrect email or password"
            }
            error(code, newMessage)
        })
    }
    
    func getURL(type: URLType) -> String {
        switch type {
        case .register:
            return "https://lubn.com/member.html"
        case .resetPwd:
            return "https://lubn.com/member-resetpassword.html"
        }
    }
    
    func siginOut() {
        UserManager.sharedInstance().reset()
    }
    
    func getPhotoURL() -> String {
        return UserManager.sharedInstance().managerInfo?.photoURL ?? ""
    }
    
    func getEmail() -> String {
        return UserManager.sharedInstance().managerInfo?.email ?? ""
    }
    
}
