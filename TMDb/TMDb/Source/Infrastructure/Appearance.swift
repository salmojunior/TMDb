//
//  Appearance.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit

struct Appearance {
    //MARK: - Public Functions
    
    /// Configure general app appearance
    static func configureApp() {
        configureNavigationBar()
        configureStatusBar()
    }
    
    //MARK: - Private Functions
    
    /// Configure Navigation Appearance
    private static func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.tmdbBlack
        UINavigationBar.appearance().tintColor = UIColor.tmdbGreen
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.tmdbGreen]
    }
    
    /// Configure StatusBar Appearance
    private static func configureStatusBar() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
