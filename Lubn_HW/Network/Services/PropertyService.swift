//
//  PropertyService.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import SwiftyJSON

class PropertyService: HttpConnectionRequest {
    override var urlname: String { return "/property" }
    
    convenience init(jwtToken: String){
        self.init(header: ["Authorization":"Bearer \(jwtToken)"])
    }
    
    func getPropertyData(mid: Int, offset: Int = 0, respnose:@escaping ([PropertyModel])->Void, error:@escaping (Int,String)->Void) {
        self.get(urlParameter: "?mid=\(mid)&offset=\(offset)", response: { (result) in
            self.errorCode = NetworkError.success.rawValue
            let resultModel = JsonModel(jsonDict: result)
            var propertyArray = [PropertyModel]()
            for tmp in resultModel.jsonDict["propertyList"].arrayValue {
                propertyArray.append(PropertyModel(jsonDict: tmp))
            }
            respnose(propertyArray)
        }) { (code, message) in
            error(code, message)
        }
    }
    
}
