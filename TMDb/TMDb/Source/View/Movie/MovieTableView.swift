//
//  MovieTableView.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit

class MovieTableView: UITableView {
    // MARK: - Public Functions
    
    func initialSetup() {
        let backgroundImageView = UIImageView(image: UIImage(named: "logo"))
        
        backgroundImageView.frame = frame
        backgroundImageView.contentMode = .center
        
        backgroundView = backgroundImageView
        accessibilityIdentifier = "UpcomingTableView"
        tableFooterView = UIView()
    }
    
    func updateElements(at indexPaths: [IndexPath]) {
        beginUpdates()
        insertRows(at: indexPaths, with: .top)
        endUpdates()
        
        backgroundView = nil
    }
    
    func initialSelectedElementStatus(imageView: UIImageView) {
        imageView.alpha = 0
    }
    
    func presentingSelectedElementStatus(imageView: UIImageView) {
        imageView.alpha = 1
    }
}
