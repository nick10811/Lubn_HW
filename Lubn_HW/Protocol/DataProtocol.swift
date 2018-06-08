//
//  DataProtocol.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/8.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DataProtocol {
    @objc optional func loadData()
    @objc optional func loadMoreData()
    
    @objc optional func numberOfSection() -> Int
    @objc optional func numberOfItemsInSection(section: Int) -> Int
    @objc optional func modelAtSection(section: Int) -> JsonModel
    @objc optional func modelAtIndex(indexPath: IndexPath) -> JsonModel
    @objc optional func isLastModel(indexPath: IndexPath) -> Bool
}
