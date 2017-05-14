//
//  MovieDetailsUISteps.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import XCTest

struct MovieDetailsUISteps: UIStepsProtocol {
    
    // MARK: - Private Constants
    
    static let titleLabelIdentifier = "titleLabel"
    
    // MARK: - BaseUISteps Protocol
    
    static func waitScreen(testCase: XCTestCase) {
        let title = XCUIApplication().staticTexts[titleLabelIdentifier]
        testCase.waitElementExists(element: title)
    }
}
