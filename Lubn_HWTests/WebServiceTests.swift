//
//  WebServiceTests.swift
//  Lubn_HWTests
//
//  Created by Nick Yang on 2018/6/9.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import XCTest
import Hippolyte
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
        Hippolyte.shared.stop()
    }
    
    func testLoginService() {
        guard let loginURL = URL(string: "https://cky9jjmd5l.execute-api.us-west-2.amazonaws.com/v0/app/signin/i") else { return }
        var stub = StubRequest(method: .POST, url: loginURL)
        let path = Bundle(for: type(of: self)).path(forResource: "response_LoginService", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let body = data
        let response: StubResponse = StubResponse.Builder()
            .stubResponse(withStatusCode: 200)
            .addHeader(withKey: "Content-Type", value: "application/json")
            .addBody(body as Data)
            .build()
        stub.response = response
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
        
        let ex = expectation(description: "LoginService")
        let webservice = LoginService(email: self.email, pwd: "nepal")
        webservice.login(respnose: { (jwtToken, managerInfo, propertyCount, propertyList) in
            XCTAssertTrue(jwtToken == self.token)
            XCTAssertTrue(managerInfo.mid == self.mid)
            XCTAssertTrue(managerInfo.email == self.email)
            XCTAssertTrue(managerInfo.photoURL == self.photourl)
            XCTAssertTrue(propertyCount == self.propertyCount)
            XCTAssertTrue(propertyList.count == 10)
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
        guard let propertyURL = URL(string: "https://cky9jjmd5l.execute-api.us-west-2.amazonaws.com/v0/app/property?mid=6&offset=0") else { return }
        var stub = StubRequest(method: .GET, url: propertyURL)
        let path = Bundle(for: type(of: self)).path(forResource: "response_PropertyService", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let body = data
        let response: StubResponse = StubResponse.Builder()
            .stubResponse(withStatusCode: 200)
            .addHeader(withKey: "Content-Type", value: "application/json")
            .addBody(body as Data)
            .build()
        stub.response = response
        Hippolyte.shared.add(stubbedRequest: stub)
        Hippolyte.shared.start()
        
        let ex = expectation(description: "PropertyService")
        let webservice = PropertyService(jwtToken: self.token)
        webservice.getPropertyData(mid: self.mid, offset: 0, respnose: { (result) in
            XCTAssertTrue(result.count == 10)
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
