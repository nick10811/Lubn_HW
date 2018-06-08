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
        self.init(header: ["Content-Type":"application/x-www-form-urlencoded"],
                  parameter: ["email":email,
                              "password":pwd])
    }
    
    func login(respnose:@escaping (String, ManagerInfoModel, Int, [PropertyModel])->Void, error:@escaping (Int,String)->Void) {
        self.post(response: { (result) in
            self.errorCode = NetworkError.success.rawValue
            let token = result["jwtToken"].stringValue
            let managerInfo = ManagerInfoModel(jsonDict: result["managerInfo"])
            let propertyCount = result["propertyCount"].intValue
            var propertyArray = [PropertyModel]()
            for tmp in result["propertyList"].arrayValue {
                propertyArray.append(PropertyModel(jsonDict: tmp))
            }
            respnose(token, managerInfo, propertyCount, propertyArray)
            
        }) { (code, msg) in
            error(code, msg)
        }
    }
    
}
