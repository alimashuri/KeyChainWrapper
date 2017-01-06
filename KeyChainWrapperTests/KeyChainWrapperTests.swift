//
//  KeyChainWrapperTests.swift
//  KeyChainWrapperTests
//
//  Created by Ali Mashuri on 1/6/17.
//  Copyright © 2017 Ali Mashuri. All rights reserved.
//

import XCTest
@testable import KeyChainWrapper

class KeyChainWrapperTests: XCTestCase {
    var account:Account!
    let credential = AccountCredential()
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        account = Account.init(email: "ali@mashuri.web.id", token: "abc123")
        credential.accessGroup = Bundle.main.bundleIdentifier
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCredentialStorage() {
        XCTAssertNotNil(account)
        XCTAssert(credential.storeAccount(account as AnyObject))
        XCTAssert(credential.isStored())
        XCTAssert((credential.retrieve() != nil))
        XCTAssertNotNil(credential.retrieve())
        XCTAssert(credential.delete())
        XCTAssertNil(credential.retrieve())
        
        
    }
    
    
    
}
