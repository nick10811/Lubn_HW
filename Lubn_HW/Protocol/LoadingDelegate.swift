//
//  WebServiceLoadingDelegate.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/8.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation

enum LoadingStatus {
    case initialize
    case loadStart
    case loadDone
    case loadFail
    case loadMoreStart
    case loadMoreDone
    case loadMoreFail
}

protocol LoadingDelegate {
    func loadingDone()
    func loadingFail(code: Int, message: String)
}
