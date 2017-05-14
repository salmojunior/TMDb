//
//  XCTestCaseExtension.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import XCTest

// MARK: - XCTestCase extension
extension XCTestCase {
    
    /// Wait an element exists to start interact with it.
    ///
    /// - Parameters:
    ///   - element: Current element
    ///   - timeout: Optional timeout. Default value is 3 seconds.
    func waitElementExists(element: XCUIElement, timeout: TimeInterval = 3) {
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
