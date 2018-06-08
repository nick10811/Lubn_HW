//
//  NetworkError.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation

enum NetworkError: Int {
    case success          = 200
    case timeout          = 1
    case parseDataFail    = 2
    case invalidParameter = 400
    case unauthorized     = 401
    case needUpgrade      = 426
}
