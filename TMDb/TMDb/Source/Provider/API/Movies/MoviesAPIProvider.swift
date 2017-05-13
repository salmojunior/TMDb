//
//  MoviesAPIProvider.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

/// <#Description#>
class MoviesAPIProvider: MoviesAPIProtocol {
    // MARK: - Private Constants
    private let upcomingEndpoint = "/movie/upcoming"
    private let pageKey = "page"
    
    /// Upcoming movies API Call
    ///
    /// - Parameters:
    ///   - page: page number
    ///   - completion: UpcmoingCallback
    func upcoming(page: Int = 1, completion: @escaping UpcmoingCallback) {
        let parameters = APIProvider.baseParameters()
        
        if var queryParameters = parameters.queryParameters {
            queryParameters[pageKey] = 1.description
        }
        
        let _ = APIProvider.sharedProvider.GET(upcomingEndpoint, parameters: parameters, header: nil) { (result) in
            completion {
                return try result()
            }
        }
    }
}