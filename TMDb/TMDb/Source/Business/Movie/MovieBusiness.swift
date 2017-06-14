//
//  MovieBusiness.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation
import Reachability

/// Callbacks for Movie methods
typealias UpcomingUICallback = (@escaping () throws -> (movies: [Movie], nextPage: Int?)) -> Void
typealias GenreUICallback = (@escaping () throws -> [Genre]) -> Void

struct MovieBusiness {
    // MARK: - Private Constants
    private let kTotalPage = "total_pages"
    private let kMoviesKey = "results"
    private let kGenresKey = "genres"
    
    // MARK: - Properties
    
    /// API Provider, public to Tests Override
    var provider: MoviesAPIProtocol = MoviesAPIProvider()
    
    // MARK: - Public Functions
    
    ///  Movies genres
    ///
    /// - Parameter completion: GenreUICallback
    func genres(completion: @escaping GenreUICallback) {
        // Check networking connection before call service
        guard Reachability.isConnected else {
            completion { throw TechnicalError.notConnected }
            
            return
        }
        
        // Call TMDb genres API service
        provider.genres { (result) in
            do {
                // Checking conditions before proccess service response
                guard let response = try result() else {
                    completion { throw BusinessError.parse(LocalizableStrings.upcoming.localize()) }
                    
                    return
                }
                guard let genresDictionary = response[self.kGenresKey] as? [[String: Any]] else {
                    completion { throw BusinessError.invalidDictionaryKey(self.kGenresKey) }
                    
                    return
                }
                
                var genres = [Genre]()
                
                // Parse genres
                for genreDictionary in genresDictionary {
                    guard let genre = Genre(dictionary: genreDictionary) else { continue }
                    genres.append(genre)
                }
                
                completion { genres }
            } catch {
                completion { throw error }
            }
        }
    }
    
    /// Upcoming movies based on page parameter if available
    ///
    /// - Parameters:
    ///   - page: wanted page
    ///   - completion: UpcomingUICallback
    func upcoming(page: Int, genres: [Genre]?, completion: @escaping UpcomingUICallback) {
        // Check networking connection before call service
        guard Reachability.isConnected else {
            completion { throw TechnicalError.notConnected }
            
            return
        }
        
        // Call TMDb movie API service
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
                    guard let movie = Movie(dictionary: movieDictionary, genres: genres) else { continue }
                    movies.append(movie)
                }
                
                completion { (movies: movies, nextPage: nextPage) }
            } catch {
                completion { throw error }
            }
        }
    }
}
