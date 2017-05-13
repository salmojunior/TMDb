//
//  MoviesAPIProtocol.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

/// callback for upcoming movies
typealias UpcmoingCallback = ( () throws -> [String:AnyObject]?) -> Void

/// A Public Protocol to enable Mock Tests
protocol MoviesAPIProtocol {
    
    /// Upcoming movies API Call
    ///
    /// - Parameters:
    ///   - page: page number
    ///   - completion: UpcmoingCallback
    func upcoming(page: Int, completion: @escaping UpcmoingCallback)
}
