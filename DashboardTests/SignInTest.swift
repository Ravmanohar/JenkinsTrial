//
//  SignInTest.swift
//  DashboardTests
//
//  Created by Xanthus Software Solutions on 12/08/20.
//  Copyright © 2020 Xanthus Software Solutions. All rights reserved.
//

import XCTest
@testable import Dashboard

class SignInTest: XCTestCase {

    var sut: SignInVC!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        super.setUp()
        
        sut = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SignInViewController") as? SignInVC
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testIfTextFieldAreConnected() throws {
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The Email UITextField is not connected")
        let pswdTextField = try XCTUnwrap(sut.pswdTextField, "The Password UITextField is not connected")
        XCTAssertEqual(emailTextField.placeholder, "Enter Email ID", "The placeholder text is wrong")
        XCTAssertEqual(pswdTextField.placeholder, "Enter Password", "The placeholder text is wrong")
        XCTAssert(emailTextField.isEnabled, "email textfield is disabled")
        XCTAssert(pswdTextField.isEnabled, "Pswd text field is disabled")
        XCTAssertEqual(emailTextField.keyboardType, .emailAddress, "Keyboard is not of type email")
    }

    func testPerformance() {
        // This is an example of a performance test case.
        self.measure {
            
        }
    }

}
