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
    
    convenience init(mid: Int, offset: Int){
        self.init(dict: ["mid":mid,
                         "offset":offset])
    }
    
    func getPropertyData(respnose:@escaping ([PropertyModel])->Void, error:@escaping (Int,String)->Void) {
        self.get(response: { (result) in
            self.errorCode = .success
            let resultModel = JsonModel(jsonDict: result)
            var propertyArray = [PropertyModel]()
            for tmp in resultModel.jsonDict["propertyList"].arrayValue {
                propertyArray.append(PropertyModel(jsonDict: tmp))
            }
            respnose(propertyArray)
            
        }) { (code, msg) in
            error(code, msg)
        }
    }
    
}
