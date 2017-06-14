//
//  MovieDetailsViewController.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, Identifiable, ViewCustomizable {
    //MARK: - Properties
    
    typealias MainView = MovieDetailsView
    private var movie: Movie? {
        didSet {
            guard let movieDetails = movie else { return }
            mainView.fulfill(movie: movieDetails)
        }
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = LocalizableStrings.movieDetailsTitle.localize()
    }
    
    // MARK: - Public Functions
    
    func selectedMovie(movie: Movie) {
        self.movie = movie
    }
    
    func posterImageViewPosition() -> CGRect {
        return mainView.posterImageViewFrame()
    }
}

// MARK: - SharedElementAnimation controller delegate
extension MovieDetailsViewController: SharedElementAnimationControllerDelegate {
    
    func willStartAnimation(animator: SharedElementAnimationController) {
        mainView.initialViewElementsStatus()
    }
    
    func didCompleteAnimation(animator: SharedElementAnimationController) {
        mainView.presentingViewElementsStatus()
    }
}
