//
//  PropertyViewModel.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/8.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import Foundation

class PropertyViewModel: BaseViewModel {
    var mid: Int = UserManager.sharedInstance().managerInfo?.mid ?? 0
    let webservice = PropertyService(jwtToken: UserManager.sharedInstance().jwtToken)
    var nextOffset: Int = 0
    
    override init() {
        super.init()
        // do not send API when get first data in login API
        if UserManager.sharedInstance().propertyList.count > 0 {
            self.status = .loadDone
        }
        self.dataConvert(array: UserManager.sharedInstance().propertyList)
    }
    
    override func loadData() {
        _ = webservice.getPropertyData(mid: self.mid, respnose: { (propertyArray) in
            self.status = .loadDone
            self.modelArray.removeAll()
            self.dataConvert(array: propertyArray)

        }, error: { (code, message) in
            self.status = .loadFail
            self.loadingDelegate?.loadingFail(code: code, message: message)

        })
    }
    
    override func loadMoreData() {
        guard nextOffset < UserManager.sharedInstance().propertyCount else {
            self.status = .noMoreData
            self.loadingDelegate?.loadingDone()
            return
        }
        
        _ = webservice.getPropertyData(mid: self.mid, offset: nextOffset, respnose: { (propertyArray) in
            self.status = .loadMoreDone
            self.dataConvert(array: propertyArray)
        }, error: { (code, message) in
            self.status = .loadMoreFail
            self.loadingDelegate?.loadingFail(code: code, message: message)
        })
    }
    
    func dataConvert(array: [PropertyModel]) {
        self.modelArray.append(contentsOf: array)
        // sorting
        self.modelArray = self.modelArray.sorted(by: { (obj1 , obj2) -> Bool in
            let pObj1 = obj1 as! PropertyModel
            let pObj2 = obj2 as! PropertyModel
            return pObj1.idx < pObj2.idx
        })
        
        // search offset
        let lastModel = self.modelArray.last as! PropertyModel
        nextOffset = lastModel.idx
        
        self.loadingDelegate?.loadingDone()
    }
    
    func setSelected(indexPath: IndexPath) {
        let model = self.modelAtIndex(indexPath: indexPath)
        model.isSelected = !model.isSelected
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return modelArray.count
    }
    
    func modelAtSection(section: Int) -> PropertyModel? {
        return nil
    }
    
    func modelAtIndex(indexPath: IndexPath) -> PropertyModel {
        return modelArray[indexPath.item] as! PropertyModel
    }
    
    func isLastModel(indexPath: IndexPath) -> Bool {
        return indexPath.item+1 == modelArray.count
    }
    
    func hasMoreData() -> Bool {
        return self.status != .noMoreData
    }
    
}
