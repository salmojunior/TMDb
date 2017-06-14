//
//  Movie.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

struct Movie {
    // MARK: - Private Constants
    private let kImagesBaseURL = "http://image.tmdb.org/t/p/w500"
    // Static Keys
    private let kMovieIdKey = "id"
    private let kTitleKey = "title"
    private let kOverviewKey = "overview"
    private let kVoteAverage = "vote_average"
    private let kGenreKey = "genre_ids"
    private let kReleaseKey = "release_date"
    private let kPosterKey = "poster_path"
    private let kBackdropKey = "backdrop_path"
    
    //MARK: - Stored Properties
    var id: Int64
    var title: String
    var overview: String
    var release: String
    var voteAverage: Double
    var genres: [Genre]?
    var posterPath: URL?
    var backdropPath: URL?
    
    // MARK: - Initializers
    init?(dictionary: [String: Any], genres: [Genre]?) {
        guard let id = dictionary[kMovieIdKey] as? Int64 else { return nil }
        guard let title = dictionary[kTitleKey] as? String else { return nil }
        guard let overview = dictionary[kOverviewKey] as? String else { return nil }
        guard let voteAverage = dictionary[kVoteAverage] as? Double else { return nil }
        guard let genresIds = dictionary[kGenreKey] as? [Int] else { return nil }
        guard let release = dictionary[kReleaseKey] as? String else { return nil }
        guard let posterPath = dictionary[kPosterKey] as? String else { return nil }
        guard let backdropPath = dictionary[kBackdropKey] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
        self.release = release
        self.posterPath = URL(string: "\(kImagesBaseURL)\(posterPath)")
        self.backdropPath = URL(string: "\(kImagesBaseURL)\(backdropPath)")
        
        if let genres = genres {
            self.genres = genres.filter { genresIds.contains($0.id) }
        }
    }
}
