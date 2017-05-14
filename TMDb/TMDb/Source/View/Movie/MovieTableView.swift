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
    
    func initialSelectedElementStatus(imageView: UIImageView) {
        imageView.alpha = 0
    }
    
    func presentingSelectedElementStatus(imageView: UIImageView) {
        imageView.alpha = 1
    }
}
