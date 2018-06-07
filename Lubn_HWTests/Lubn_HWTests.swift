//
//  Lubn_HWTests.swift
//  Lubn_HWTests
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import XCTest
@testable import Lubn_HW

class Lubn_HWTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetVideoDate() {
        let service = LoginService(email: "nick10811@gmail.com", pwd: "nepal")
        service.login(respnose: { (result) in
            XCTAssert(service.errorCode == .success)
            
        }) { (code, message) in
            XCTAssert(false)
        }
    }
    
}
