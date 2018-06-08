//
//  HttpClient.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Reachability

class HttpClient {
    
    private var sessionManager: SessionManager!
    
    private static var instance: HttpClient?
    static func sharedInstance(timeoutSecond: Double=10) -> HttpClient {
        if instance == nil {
            instance = HttpClient(timeoutSecond: timeoutSecond)
        }
        return instance!
    }
    
    init(timeoutSecond: Double) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutSecond
        configuration.timeoutIntervalForResource = timeoutSecond
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    /// Creates a `Http Request` to retrieve the contents of the specified `url`, `method`, `parameters` and `headers`.
    ///
    /// - parameter method:        The HTTP method. `.get` by default.
    /// - parameter url:           The URL.
    /// - parameter headers:       The HTTP headers. `nil` by default.
    /// - parameter parameters:    The parameters. `nil` by default.
    /// - parameter response: The closure of successfal
    /// - parameter error:        The closure of failed
    ///
    /// - returns: The created `Http Request`.
    func request(_ method: Alamofire.HTTPMethod, _ url: String, _ headers:[String:String]? = nil, _ parameters:[String:Any]? = nil, response:@escaping (JSON)->(), error:@escaping (Int, String)->()) {
        printLog(.info, "Send:\n\(url), \nheader:\n\(String(describing: headers)) \npara:\n  \(String(describing: parameters))")
        
        sessionManager.request(url, method: method, parameters: parameters, encoding:URLEncoding.default, headers:headers).validate().responseJSON { data -> Void in
            printLog(.debug, data.result)
            switch data.result{
            case .success:
                if let value = data.result.value {
                    let json = JSON(value)
                    printLog(.info,"Back:\(String(describing: data.request?.url?.absoluteString)) , Result:\(json)")
                    response(json)
                } else {
                    error(NetworkError.parseDataFail.rawValue, "Cannot parse response data")
                }
                
            case .failure:
                var errorCode = NetworkError.timeout.rawValue // default is network problem
                if let status = data.response?.statusCode {
                    errorCode = status
                    printLog(.error, "Request Failed and Error code: \(errorCode)")
                } else {
                    printLog(.error, "Network problem causes request failed")
                }
                
                var message = data.error?.localizedDescription
                message = message == nil ? "Unstale Network" : message
                error(errorCode, message!)
            }
        }
        
    }
    
    func isNetworkAvailable() -> Bool {
        let reachability = Reachability()!
        if (reachability.connection == .none) {
            return false
        }
        return true
    }
    
}
