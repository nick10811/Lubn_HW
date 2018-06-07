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
    var errorCode: NetworkError = .success
    var urlname: String {return ""}
    
    var dict: [String:Any]
    
    /// Inital a request connection
    ///
    /// - parameter dict:        The parameters by dictionary.
    init(dict: [String:Any]) {
        self.dict = dict
    }
    
    func post(response:@escaping(JSON)->Void, error:@escaping(Int, String)->Void) {
        let url = serverIP+urlname
        printLog(.debug, "HttpConnection:\(url), dictString: \(dict)" )
        _ = HttpClient.sharedInstance().request(.post, url, ["X-App-Version":"iv1.0",
                                                             "accept":"application/json",
                                                             "X-Api-Key":"cucXZsH1HlcE5lqzUQua2K6ThXjEFyTNc7vqmkiuYfpHc8OIFfaNXRhwM7HHh8G",
                                                             "Content-Type":"application/x-www-form-urlencoded"],
                                                dict, response: { (result) in
            response(result)
        }, error: { (code, message) in
            self.errorCode = code
            error(code.rawValue, message)
        })
    }
}
