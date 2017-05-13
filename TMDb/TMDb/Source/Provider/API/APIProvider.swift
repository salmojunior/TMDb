//
//  APIProvider.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

struct APIProvider {
    // MARK: - Properties
    
    /// API version
    private static let apiVersion = "3"
    /// Auth header Key
    private static let authKey = "api_key"
    private static let authValue = "1f54bd990f1cdfb230adb312546d765d"
    /// Language Key
    private static let languageKey = "language"
    /// Shared Networking Provider used to access API Services
    static var sharedProvider: NetworkingProvider {
        let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        guard let baseURL = URL(string: APIProvider.baseURL()) else { fatalError("Base URL should not be empty") }
        
        return NetworkingProvider(session: urlSession, baseURL: baseURL)
    }
    
    // MARK: - Public Static Functions
    
    /// API Base URL
    ///
    /// - Returns: return baseURL
    private static func baseURL() -> String {
        return "https://api.themoviedb.org/" + apiVersion
    }
    
    /// Base Header for authentication
    ///
    /// - Returns: Dictionary<String, String>
    static func baseParameters() -> NetworkingParameters {
        var queryParameters = [authKey:authValue]
        
        if let appLang = Locale.current.languageCode {
            queryParameters[languageKey] = appLang
        }
        
        let parameters: NetworkingParameters = (bodyParameters: nil, queryParameters: queryParameters)
        
        return parameters
    }
}
