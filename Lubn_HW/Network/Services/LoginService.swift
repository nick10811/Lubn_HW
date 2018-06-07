//
//  LoginService.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginService: HttpConnectionRequest {
    override var urlname: String { return "/signin/i" }
    
    convenience init(email: String, pwd: String){
        self.init(dict: ["email":email,
                         "password":pwd])
    }
    
    func login(respnose:@escaping (JSON)->Void, error:@escaping (Int,String)->Void) {
        self.post(response: { (result) in
            self.errorCode = .success
            respnose(result)
            
        }) { (code, msg) in
            error(code, msg)
        }
    }
    
}
