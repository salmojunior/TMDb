//
//  MoviesTableViewController.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    // MARK: - Private Constants
    private let kManager = MovieManager()
    private let kMovieCellIdentifier = "movieIdentifier"
    
    // MARK: - Private Properties
    private var nextPage: Int? = 1
    private var genres: [Genre]?
    private var movies = [Movie]()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = LocalizableStrings.upcomingTitle.localize()
        clearsSelectionOnViewWillAppear = false
        tableView.tableFooterView = UIView()
        refreshControl?.addTarget(self, action: #selector(MoviesTableViewController.loadMovies), for: UIControlEvents.valueChanged)
        
        loadGenres()
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
    
    private func updateElements(indexPaths: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .top)
        tableView.endUpdates()
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
                
                weakSelf.updateElements(indexPaths: indexPaths)
                weakSelf.endRefresing()
            } catch {
                weakSelf.endRefresing()
                HandleError.handle(error: error)
            }
        }
    }
}
