//
//  LocalizableStrings.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

enum LocalizableStrings : String {
    // MARK: - Constants
    
    // Error Handling
    case unexpectedError
    case invalidValue
    case httpError
    case errorOnParseRequest
    case notConnected
    case errorTitle
    case hide
    
    // Movies
    case upcoming
    case upcomingTitle
    case release
    case movieDetailsTitle
    case genres
    case title
    case overview
    
    // MARK: - Public Functions
    
    /**
     This method localizes the raw value of the object
     
     - returns: Return the localized string for that key
     */
    func localize() -> String {
        return self.rawValue.localized
    }
}

// MARK: - String Extension
private extension String {
    
    /// Get localized string without comment
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
