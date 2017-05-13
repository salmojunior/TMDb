//
//  MovieBusiness.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

/// Callbacks for Movie methods
typealias UpcomingUICallback = (@escaping () throws -> (movies: [Movie], nextPage: Int?)) -> Void

struct MovieBusiness {
    // MARK: - Private Constants
    private let kTotalPage = "total_pages"
    private let kMoviesKey = "results"
    
    // MARK: - Properties
    
    /// API Provider, public to Tests Override
    var provider: MoviesAPIProtocol = MoviesAPIProvider()
    
    // MARK: - Public Functions
    
    
    /// Upcoming movies based on page parameter if available
    ///
    /// - Parameters:
    ///   - page: wanted page
    ///   - completion: UpcomingUICallback
    func upcoming(page: Int, completion: @escaping UpcomingUICallback) {
        provider.upcoming(page: page) { (result) in
            do {
                // Checking conditions before proccess service response
                guard let response = try result() else {
                    completion { throw BusinessError.parse(LocalizableStrings.upcoming.localize()) }
                    
                    return
                }
                guard let totalPages = response[self.kTotalPage] as? Int else {
                    completion { throw BusinessError.invalidDictionaryKey(self.kTotalPage) }
                    
                    return
                }
                guard let moviesDictionary = response[self.kMoviesKey] as? [[String: Any]] else {
                    completion { throw BusinessError.invalidDictionaryKey(self.kMoviesKey) }
                    
                    return
                }
                
                // Return values
                var nextPage: Int?
                var movies = [Movie]()
                
                //Calculate if there is more pages to available
                if page < totalPages {
                    nextPage = page + 1
                }
                
                // Parse movies
                for movieDictionary in moviesDictionary {
                    guard let movie = Movie(dictionary: movieDictionary) else { continue }
                    movies.append(movie)
                }
                
                completion { (movies: movies, nextPage: nextPage) }
            } catch {
                completion { throw error }
            }
        }
    }
}
