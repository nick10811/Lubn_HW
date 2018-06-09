//
//  AuthViewModelTests.swift
//  Lubn_HWTests
//
//  Created by Nick Yang on 2018/6/9.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import XCTest
@testable import Lubn_HW

class AuthViewModelTests: XCTestCase {
    let viewModel = AuthViewModel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetURL() {
        let registerURL: String = viewModel.getURL(type: .register)
        XCTAssert(registerURL == "https://lubn.com/member.html")
        
        let resetPwdURL = viewModel.getURL(type: .resetPwd)
        XCTAssert(resetPwdURL == "https://lubn.com/member-resetpassword.html")
        
    }
    
    func testSignOut() {
        viewModel.siginOut()
        let jwtToken = UserManager.sharedInstance().jwtToken
        XCTAssert(jwtToken == "")
    }
    
}
