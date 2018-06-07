//
//  UserManager.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation

class UserManager {
    var jwtToken: String?
    var managerInfo: ManagerInfoModel?
    var propertyList = [PropertyModel]()
    
    private static var instance: UserManager?
    static func sharedInstance() -> UserManager {
        if instance == nil {
            instance = UserManager()
        }
        return instance!
    }
}
