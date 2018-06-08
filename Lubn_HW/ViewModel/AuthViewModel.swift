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
    let user = UserManager.sharedInstance()
    let setting = SettingManager.sharedInstance()
    
    func siginIn(email: String,
                 pwd: String,
                 completion:@escaping ()->Void,
                 error:@escaping (Int,String)->Void) {
        
        let webservice = LoginService(email: email, pwd: pwd)
        _ = webservice.login(respnose: { (token, managerInfo, propertyCount, propertyArray) in
            // store user data
            self.user.jwtToken = token
            self.user.managerInfo = managerInfo
            self.user.propertyCount = propertyCount
            self.user.addPropertyArray(array: propertyArray)
            self.afterSiginIn()
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
        user.reset()
        setting.remove(forKey: "JwtToken")
        setting.remove(forKey: "PropertyCount")
        setting.remove(forKey: "ManagerInfo")
    }
    
    func getPhotoURL() -> String {
        return user.managerInfo?.photoURL ?? ""
    }
    
    func getEmail() -> String {
        return user.managerInfo?.email ?? ""
    }
    
    private func afterSiginIn() {
        setting.save(user.jwtToken, forKey: "JwtToken")
        setting.save("\(user.propertyCount)", forKey: "PropertyCount")
        if user.managerInfo != nil {
            let archivedData = NSKeyedArchiver.archivedData(withRootObject: user.managerInfo!)
            setting.saveObject(archivedData as AnyObject, forKey: "ManagerInfo")
        }
    }
    
    func needSiginIn() -> Bool {
        var jwtToken: String = ""
        var propertyCount: Int? = nil
        var managerInfo: ManagerInfoModel? = nil
        
        jwtToken = setting.load("JwtToken") ?? ""
        propertyCount = Int(setting.load("PropertyCount") ?? "")
        let unarchivedData: Data? = setting.loadObject("ManagerInfo") as? Data
        if unarchivedData != nil {
            managerInfo = NSKeyedUnarchiver.unarchiveObject(with: unarchivedData!) as? ManagerInfoModel
        }
        
        if jwtToken == "" ||
            propertyCount == nil ||
            managerInfo == nil {
            return true
        }
        user.jwtToken = jwtToken
        user.propertyCount = propertyCount ?? 0
        user.managerInfo = managerInfo
        return false
    }
    
}
