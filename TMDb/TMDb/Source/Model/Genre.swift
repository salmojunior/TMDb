//
//  Genre.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

struct Genre {
    // MARK: - Private Constants
    // Static Keys
    private let kMovieIdKey = "id"
    private let kNameKey = "name"
    
    //MARK: - Stored Properties
    var id: Int
    var name: String
    
    // MARK: - Initializers
    init?(dictionary: [String: Any]) {
        guard let id = dictionary[kMovieIdKey] as? Int else { return nil }
        guard let name = dictionary[kNameKey] as? String else { return nil }
        
        self.id = id
        self.name = name
    }
}
