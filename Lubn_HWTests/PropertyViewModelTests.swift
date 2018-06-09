//
//  PropertyViewModelTests.swift
//  Lubn_HWTests
//
//  Created by Nick Yang on 2018/6/9.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import XCTest
@testable import Lubn_HW

class PropertyViewModelTests: XCTestCase {
    let viewModel = PropertyViewModel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // insert fake data
        for _ in 0...3{
            let model = PropertyModel()
            viewModel.modelArray.append(model)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfItemsInSection() {
        XCTAssert(viewModel.modelArray.count == viewModel.numberOfItemsInSection(section: 0))
    }
    
}
