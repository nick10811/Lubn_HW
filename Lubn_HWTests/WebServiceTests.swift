//
//  WebServiceTests.swift
//  Lubn_HWTests
//
//  Created by Nick Yang on 2018/6/9.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Lubn_HW

class WebServiceTests: XCTestCase {
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtZW1iZXIiOjYsImlhdCI6MTUyODU1MTIzNCwiZXhwIjoxNTI4NTU0ODk0LCJhdWQiOiJhcHAiLCJpc3MiOiJpbnRlcnZpZXcubHVibi5jb20ifQ.Tj_MNAB7rUPkKb50-g90UwVCLSSH4qIOhWe_8HQvl4E"
    let mid = 6
    let email = "nick10811@gmail.com"
    let photourl = "https://s3.amazonaws.com/lubn-interview/n.jpg"
    let propertyCount = 24
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testLoginService() {
        let ex = expectation(description: "LoginService")
        stub(condition: isPath("https://cky9jjmd5l.execute-api.us-west-2.amazonaws.com/v0/app/signin/i")) { request in
            let stubPath = OHPathForFile("response_LoginService.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        let webservice = LoginService(email: self.email, pwd: "nepal")
        webservice.login(respnose: { (jwtToken, managerInfo, propertyCount, propertyList) in
//            XCTAssert(jwtToken == self.token)
            XCTAssert(managerInfo.mid == self.mid)
            XCTAssert(managerInfo.email == self.email)
            XCTAssert(managerInfo.photoURL == self.photourl)
            XCTAssert(propertyCount == self.propertyCount)
            XCTAssert(propertyList.count == 10)
            ex.fulfill()
            
        }) { (code, message) in
            XCTAssert(false)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
        
    }
    
    func testPropertyService() {
        let ex = expectation(description: "PropertyService")
        stub(condition: isPath("https://cky9jjmd5l.execute-api.us-west-2.amazonaws.com/v0/app/property?mid=6&offset=0")) { request in
            let stubPath = OHPathForFile("response_PropertyService.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        let webservice = PropertyService(jwtToken: self.token)
        webservice.getPropertyData(mid: self.mid, offset: 0, respnose: { (result) in
            XCTAssert(result.count == 10)
            ex.fulfill()
        }) { (code, message) in
            XCTAssert(false)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
        
    }
    
}
