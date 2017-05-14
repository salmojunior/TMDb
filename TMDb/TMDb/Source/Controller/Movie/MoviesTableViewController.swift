//
//  MoviesTableViewController.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController, ViewCustomizable {
    // MARK: - Private Constants
    private let kManager = MovieManager()
    private let kMovieCellIdentifier = "movieIdentifier"
    
    // MARK: - Private Properties
    typealias MainView = MovieTableView
    private var nextPage: Int? = 1
    private var genres: [Genre]?
    private var movies = [Movie]()
    fileprivate var selectedItemFrame = CGRect.zero
    fileprivate var destinationItemFrame = CGRect.zero
    fileprivate var sourceImageView: UIImageView?
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = LocalizableStrings.upcomingTitle.localize()
        navigationController?.delegate = self
        refreshControl?.addTarget(self, action: #selector(MoviesTableViewController.loadMovies), for: UIControlEvents.valueChanged)
        mainView.initialSetup()
        
        loadGenres()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case MovieDetailsViewController.identifier:
            guard let movieDetailsViewController = segue.destination as? MovieDetailsViewController else {
                return
            }
            guard let selectedMovie = sender as? Movie else { return }
            
            movieDetailsViewController.selectedMovie(movie: selectedMovie)
            destinationItemFrame = movieDetailsViewController.posterImageViewPosition()
        default:
            return
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMovieCellIdentifier, for: indexPath) as! MovieTableViewCell

        let movie = movies[indexPath.row]
        cell.fillIn(movie: movie)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
        
        sourceImageView = cell.posterImageView
        
        if let imageView = sourceImageView {
            selectedItemFrame = imageView.superview!.convert(imageView.frame, to: nil)
            performSegue(withIdentifier: MovieDetailsViewController.identifier, sender: movie)
        }
    }
    
    // MARK: - Private Functions
    
    private func loadGenres() {
        kManager.genres {[weak self] (result) in
            guard let weakSelf = self else { return }
            
            do {
                weakSelf.genres = try result()
                weakSelf.loadMovies()
            } catch {
                HandleError.handle(error: error)
            }
        }
    }
    
    private func endRefresing() {
        refreshControl?.endRefreshing()
    }
        
    // Using @objc notation to let the function be private and also be visible to #selector usage
    @objc private func loadMovies() {
        guard let nextPage = nextPage else {
            endRefresing()
            
            return
        }
        
        kManager.upcoming(page: nextPage, genres: genres) {[weak self] (result) in
            guard let weakSelf = self else { return }
            
            do {
                let (newMovies, nextPage) = try result()
                
                weakSelf.movies = newMovies + weakSelf.movies
                weakSelf.nextPage = nextPage
                
                var indexPaths = [IndexPath]()
                
                for (index, _) in newMovies.enumerated() {
                    let indexPath = IndexPath(item: index, section: 0)
                    indexPaths.append(indexPath)
                }
                
                weakSelf.endRefresing()
                weakSelf.mainView.updateElements(at: indexPaths)
            } catch {
                weakSelf.endRefresing()
                HandleError.handle(error: error)
            }
        }
    }
}

// MARK: - Navigation controller delegate
extension MoviesTableViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let imageView = sourceImageView else { return nil }
        
        var animatorDelegate: SharedElementAnimationControllerDelegate?
        var mode = SharedAnimationMode.push
        
        if let toViewController = toVC as? SharedElementAnimationControllerDelegate {
            animatorDelegate = toViewController
        }
        
        if toVC == self {
            mode = .pop
        }
        
        let transition = SharedElementAnimationController(originFrame: selectedItemFrame, destineFrame: destinationItemFrame, sourceImageView: imageView, animationMode: mode, delegate: animatorDelegate)
        
        return transition
    }
}

// MARK: - SharedElementAnimation controller delegate
extension MoviesTableViewController: SharedElementAnimationControllerDelegate {
    
    func willStartAnimation(animator: SharedElementAnimationController) {
        guard let imageView = sourceImageView else { return }
        mainView.initialSelectedElementStatus(imageView: imageView)
    }
    
    func didCompleteAnimation(animator: SharedElementAnimationController) {
        guard let imageView = sourceImageView else { return }
        mainView.presentingSelectedElementStatus(imageView: imageView)
    }
}
