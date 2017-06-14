//
//  BaseUITests.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import XCTest

class BaseUITests: XCTestCase {
    // MARK: - Constants
    let app = XCUIApplication()
    
    // MARK: - Overrides
    
    override func setUp() {
        super.setUp()
        
        XCUIDevice.shared().orientation = .portrait
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
}
