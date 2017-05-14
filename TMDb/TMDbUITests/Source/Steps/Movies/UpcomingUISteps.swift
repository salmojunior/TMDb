//
//  UpcomingUISteps.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import XCTest

struct UpcomingUISteps: UIStepsProtocol {
    // MARK: - Private Constants
    
    private static let kTitleLabel = "Upcoming Movies"
    private static let kUpcomingTableViewIdentifier = "UpcomingTableView"
    
    // MARK: - BaseUISteps Protocol
    
    static func waitScreen(testCase: XCTestCase) {
        let upcomingMoviesStaticText = XCUIApplication().navigationBars[kTitleLabel]
        testCase.waitElementExists(element: upcomingMoviesStaticText)
    }
    
    static func tapMovie(index: UInt) {
        let tableView = XCUIApplication().tables.containing(.table, identifier: kUpcomingTableViewIdentifier)
        XCTAssertTrue(tableView.cells.count > 0)
        
        let firstCell = tableView.cells.element(boundBy: index)
        firstCell.tap()
    }
}
