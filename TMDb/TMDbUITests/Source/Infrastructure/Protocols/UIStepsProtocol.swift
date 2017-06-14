//
//  UIStepsProtocol.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import XCTest

protocol UIStepsProtocol {
    
    /// Wait screen be avaible for test
    ///
    /// - Parameter testCase: Current screen testCase instance
    static func waitScreen(testCase: XCTestCase)
}
