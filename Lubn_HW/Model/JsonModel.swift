//
//  JsonModel.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonModel: NSObject {
    var jsonDict:JSON
    
    init(jsonDict:JSON){
        self.jsonDict = jsonDict
    }
}

class ManagerInfoModel: JsonModel {
    var mid: Int = 0
    var email: String = ""
    var photoURL: String = ""
    
    override init(jsonDict: JSON) {
        super.init(jsonDict: jsonDict)
        self.mid = self.jsonDict["mid"].intValue
        self.email = self.jsonDict["email"].stringValue
        self.photoURL = self.jsonDict["photourl"].stringValue
    }
}

class PropertyModel: JsonModel {
    var idx: Int = 0
    var addr: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    var country: String = ""
    var isSelected: Bool = false
    
    override init(jsonDict: JSON) {
        super.init(jsonDict: jsonDict)
        self.idx = self.jsonDict["idx"].intValue
        self.addr = self.jsonDict["addr"].stringValue
        self.city = self.jsonDict["city"].stringValue
        self.state = self.jsonDict["state"].stringValue
        self.zip = self.jsonDict["zip"].stringValue
        self.country = self.jsonDict["country"].stringValue
    }
    
}
