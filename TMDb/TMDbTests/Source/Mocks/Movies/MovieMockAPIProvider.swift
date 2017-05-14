//
//  MovieMockAPIProvider.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation
@testable import TMDb


/// Movies Mock API Provider
class MoviesMockAPIProvider: MoviesAPIProtocol {
    // MARK: - Constants
    private let kMockingFilesExtension = "json"
    private let kMockingMoviesFileName = "upcoming"
    private let kMockingGenresFileName = "genres"
    
    // MARK: - Mocking Movies Service Functions
    
    /// Upcoming movies API Call
    ///
    /// - Parameters:
    ///   - page: page number
    ///   - completion: UpcmoingCallback
    func upcoming(page: Int = 1, completion: @escaping UpcmoingCallback) {
        let testBundle = Bundle(for: type(of: self))
        
        guard let path = testBundle.path(forResource: kMockingMoviesFileName, ofType: kMockingFilesExtension) else {
            completion { throw TechnicalError.parse(kMockingMoviesFileName) }
            
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let resultDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
            
            completion { resultDictionary }
        } catch {
            completion { throw TechnicalError.requestError }
        }
    }
    
    /// Genre movies API Call
    ///
    /// - Parameter completion: GenreCallback
    func genres(completion: @escaping GenreCallback) {
        let testBundle = Bundle(for: type(of: self))
        
        guard let path = testBundle.path(forResource: kMockingGenresFileName, ofType: kMockingFilesExtension) else {
            completion { throw TechnicalError.parse(kMockingGenresFileName) }
            
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let resultDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
            
            completion { resultDictionary }
        } catch {
            completion { throw TechnicalError.requestError }
        }
    }
}
