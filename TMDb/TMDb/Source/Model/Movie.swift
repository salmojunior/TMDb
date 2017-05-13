//
//  Movie.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

struct Movie {
    //MARK: - Private Static Keys
    private let kMovieIdKey = "id"
    private let kTitleKey = "title"
    private let kOverviewKey = "overview"
    private let kGenreKey = "genre_ids"
    private let kReleaseKey = "release_date"
    private let kPosterKey = "poster_path"
    private let kBackdropKey = "backdrop_path"
    
    //MARK: - Stored Properties
    var id: Int64
    var title: String
    var overview: String
    var genre: [Int]
    var release: String
    var posterPath: String
    var backdropPath: String
    
    // MARK: - Initializers
    init?(dictionary: [String: Any]) {
        guard let id = dictionary[kMovieIdKey] as? Int64 else { return nil }
        guard let title = dictionary[kTitleKey] as? String else { return nil }
        guard let overview = dictionary[kOverviewKey] as? String else { return nil }
        guard let genre = dictionary[kGenreKey] as? [Int] else { return nil }
        guard let release = dictionary[kReleaseKey] as? String else { return nil }
        guard let posterPath = dictionary[kPosterKey] as? String else { return nil }
        guard let backdropPath = dictionary[kBackdropKey] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.overview = overview
        self.genre = genre
        self.release = release
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}
