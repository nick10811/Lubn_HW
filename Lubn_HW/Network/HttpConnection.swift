//
//  HttpConnection.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import SwiftyJSON

class HttpConnectionRequest {
    var errorCode: Int = NetworkError.success.rawValue
    var urlname: String {return ""}
    
    var header: [String:String] = ["X-App-Version":appVer,
                                   "X-Api-Key":apiKey,
                                   "accept":"application/json"]
    var parameter: [String:Any] = [:]
    
    /// Inital a request connection
    ///
    /// - header  header      :        The headers by dictionary.
    /// - parameter parameter :        The parameters by dictionary.
    init(header: [String:String]? = nil, parameter: [String:Any]? = nil) {
        if header != nil {
            for (key,value) in header! {
                self.header.updateValue(value, forKey: key)
            }
        }
        
        if parameter != nil {
            self.parameter = parameter!
        }
    }
    
    func post(response:@escaping(JSON)->Void, error:@escaping(Int, String)->Void) {
        let url = serverIP+urlname
        printLog(.debug, "[POST] HttpConnection:\(url), dictString: \(parameter)" )
        _ = HttpClient.sharedInstance().request(.post, url, header,                                              parameter, response: { (result) in
            response(result)
        }, error: { (code, message) in
            self.errorCode = code
            error(code, message)
        })
    }
    
    func get(urlParameter: String, response:@escaping(JSON)->Void, error:@escaping(Int, String)->Void) {
        let url = serverIP+urlname+urlParameter
        printLog(.debug, "[GET] HttpConnection:\(url), dictString: \(parameter)" )
        _ = HttpClient.sharedInstance().request(.get, url, header,                                                parameter, response: { (result) in                                                    response(result)
        }, error: { (code, message) in
            self.errorCode = code
            error(code, message)
        })
    }
}
