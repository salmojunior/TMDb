//
//  MovieManager.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

class MovieManager: BaseManager {
    // MARK: - Properties
    
    /// Movie Business
    private lazy var movieBusiness: MovieBusiness = {
        return MovieBusiness()
    }()
    
    // MARK: - Public Functions
    
    /// Upcoming movies based on page parameter if available
    ///
    /// - Parameters:
    ///   - page: wanted page
    ///   - completion: UpcomingUICallback
    func upcoming(page: Int, completion: @escaping UpcomingUICallback) {
        operations.addOperation {
            self.movieBusiness.upcoming(page: page, completion: { (result) in
                OperationQueue.main.addOperation {
                    completion(result)
                }
            })
        }
    }
}
