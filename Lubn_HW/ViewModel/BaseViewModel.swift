//
//  BaseViewModel.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/8.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation

class BaseViewModel {
    var loadingDelegate: LoadingDelegate?
    var status: LoadingStatus = .initialize
    var modelArray = [JsonModel]()
    
    func nextStatus() {
        switch status {
        case .initialize, .loadFail:
            self.status = .loadStart
            self.loadData()
        case .loadDone, .loadMoreDone, .loadMoreFail:
            self.status = .loadMoreStart
            self.loadMoreData()
        default:
            break
        }
    }
    
    func refreshData() {
        if (self.status != .loadStart) {
            self.status = .initialize
            self.nextStatus()
        }
    }
}

extension BaseViewModel: DataProtocol {
    func loadData() {
    }
    
    func loadMoreData() {
    }
}

