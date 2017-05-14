//
//  MoviesUITests.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import XCTest

class MoviesUITests: BaseUITests {
    // MARK: - UI Tests
    
    /// Movie Details screen UI Test
    func testMovieDetails() {
        UpcomingUISteps.waitScreen(testCase: self)
        UpcomingUISteps.tapMovie(index: 0)
        MovieDetailsUISteps.waitScreen(testCase: self)
        
        let titleLabel = app.staticTexts[MovieDetailsUISteps.titleLabelIdentifier]
        
        XCTAssert(titleLabel.exists, "Detail screen was not shown.")
    }
}
