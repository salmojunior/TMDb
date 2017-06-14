//
//  MoviesTests.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import XCTest
@testable import TMDb

/// Unit Tests for Movies business layer
class MoviesTests: XCTestCase {
    // MARK: - Properties
    private var mockProvider: MoviesAPIProtocol?
    
    // MARK: - Overrides
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockProvider = MoviesMockAPIProvider()
    }
    
    // MARK: - Tests
    
    func testUpcoming() {
        let expectedNextPage = 2
        let expectedMoviesCount = 20
        
        guard let provider = mockProvider else {
            XCTAssert(false, "Fail to unwrap mock provider")
            
            return
        }
        
        let business = MovieBusiness(provider: provider)
        
        business.upcoming(page: 1, genres: []) { (result) in
            do {
                let (newMovies, nextPage) = try result()
                
                guard let page = nextPage else {
                    XCTAssert(false, "Fail to parse next page response")
                    
                    return
                }
    
                XCTAssert(page == expectedNextPage, "Unexpected page response")
                XCTAssert(newMovies.count == expectedMoviesCount, "Failed - Unexpected movies response")
            } catch {
                XCTAssert(false, "Fail to unwrap provider response")
            }
        }
    }
    
    func testGenres() {
        let expectedGenresCount = 19
        
        guard let provider = mockProvider else {
            XCTAssert(false, "Fail to unwrap mock provider")
            
            return
        }
        
        let business = MovieBusiness(provider: provider)
        
        business.genres { (result) in
            do {
                let genres = try result()
                
                XCTAssert(genres.count == expectedGenresCount, "Unexpected genres response")
            } catch {
                XCTAssert(false, "Fail to unwrap provider response")
            }
        }
    }
}
