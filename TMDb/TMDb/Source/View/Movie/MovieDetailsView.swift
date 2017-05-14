//
//  MovieDetailsView.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class MovieDetailsView: UIView {
    // MARK: - Constants
    private let kRatingNormalize = 2.0
    private let kPlaceholderImageName = "logo"
    
    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var backdropImageView: UIImageView!
    
    // MARK: - Public Functions
    
    /// Fill screen in with movie details
    ///
    /// - Parameter movie: Movie object
    func fulfill(movie: Movie) {
        // Update Labels
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDateLabel.text = "\(LocalizableStrings.release.localize()): \(movie.release)"
        ratingView.rating = movie.voteAverage / kRatingNormalize
        genresLabel.text = movie.genres?.reduce("", { (text, genre) -> String in
            return "\(text)\n\(genre.name)"
        })
        
        // Update image views elements
        let placeholder = UIImage(named: kPlaceholderImageName)
        
        guard let posterURL = movie.posterPath else {
            posterImageView.image = placeholder
            
            return
        }
        guard let backdropURL = movie.backdropPath else {
            backdropImageView.image = placeholder
            
            return
        }
        
        let posterResource = ImageResource(downloadURL: posterURL, cacheKey: posterURL.description)
        let backdropResource = ImageResource(downloadURL: backdropURL, cacheKey: backdropURL.description)
        
        posterImageView.kf.setImage(with: posterResource, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        backdropImageView.kf.setImage(with: backdropResource, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
