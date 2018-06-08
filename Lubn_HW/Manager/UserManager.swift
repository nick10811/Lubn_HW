//
//  UserManager.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserManager {
    var jwtToken: String = ""
    var managerInfo: ManagerInfoModel?
    var propertyList = [PropertyModel]()
    var propertyCount: Int = 0
    
    private static var instance: UserManager?
    static func sharedInstance() -> UserManager {
        if instance == nil {
            instance = UserManager()
        }
        return instance!
    }
    
    func addPropertyArray(array: [PropertyModel]) {
        self.propertyList.append(contentsOf: array)
    }
    
    func reset() {
        self.jwtToken = ""
        self.managerInfo = nil
        self.propertyCount = 0
        self.propertyList.removeAll()
    }
}
