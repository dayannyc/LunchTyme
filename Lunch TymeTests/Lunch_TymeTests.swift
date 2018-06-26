//
//  Lunch_TymeTests.swift
//  Lunch TymeTests
//
//  Created by Dayanny Caballero on 6/25/18.
//  Copyright © 2018 dayannyc. All rights reserved.
//

import XCTest
@testable import Lunch_Tyme

class Lunch_TymeTests: XCTestCase {
    
    var loginVC: LoginViewController!
    var registerVC: RegisterViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lVC = storyboard.instantiateViewController(withIdentifier: "initialScreen") as! LoginViewController
        let rVC = storyboard.instantiateViewController(withIdentifier: "registerVC") as! RegisterViewController
        loginVC = lVC
        registerVC = rVC
        _ = loginVC.view
        _ = registerVC.view
        
    }
    
    override func tearDown() {
        loginVC = nil
        registerVC = nil
        super.tearDown()

    }
    
    func testLogin() {
        loginVC.loginPresenter = LoginPresenter(view: loginVC)
        loginVC.loginPresenter?.login(email: "", password: "tempPassword")
        let errorMsg = loginVC.loginPresenter?.error
        XCTAssertEqual(errorMsg, "Email field cannot be left blank")
    }
    
    func testRegister() {
        registerVC.registerPresenter = RegistrationPresenter(view: registerVC)
        registerVC.registerPresenter?.register(email: "dayanny.caballero@gmail.com", password: "")
        let errorMsg = registerVC.registerPresenter?.error
        XCTAssertEqual(errorMsg, "Password field cannot be left blank")
    }
}
