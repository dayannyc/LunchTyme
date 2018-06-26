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
    
    var resPage: RestaurantsViewController!
    
    override func setUp() {
        super.setUp()
        let resPage = RestaurantsViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        resPage = nil
        super.tearDown()

    }
    
    func testGettingRestaurants() {
       // resPage.
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
