//
//  MovieTableViewCell.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!

    // MARK: - Public Functions
    
    func fillIn(movie: Movie) {
        // Update Labels
        titleLabel.text = movie.title
        releaseDateLabel.text = "\(LocalizableStrings.release.localize()): \(movie.release)"
        
        // Update Genres Label
        guard let genres = movie.genres else { return }
        
        var genresText = genres.reduce("", { (text, genre) -> String in
            return "\(text)\(genre.name), "
        })
        let endIndex = genresText.index(genresText.endIndex, offsetBy: -2)
        genresText = genresText.substring(to: endIndex)
        genreLabel.text = genresText
        
        // Update Image View
        let placeholder = UIImage(named: "logo")
        guard let posterURL = movie.posterPath else {
            posterImageView.image = placeholder
            
            return
        }
        
        let posterResource = ImageResource(downloadURL: posterURL, cacheKey: posterURL.description)
        
        posterImageView.kf.setImage(with: posterResource, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        
        // Ajustements on Accessibility
        genreLabel.accessibilityLabel = "\(LocalizableStrings.genres.localize()): \(genresText)"
        accessibilityTraits = UIAccessibilityTraitButton
    }
}
