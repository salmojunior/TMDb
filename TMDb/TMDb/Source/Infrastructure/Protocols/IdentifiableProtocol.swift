//
//  IdentifiableProtocol.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit

//MARK: - Identifiable protocol

/**
 *  Used to UIViewController that are stored in Storyboard
 */
protocol Identifiable : class {
    
}

// MARK: - Identifiable Extension on UIViewController
extension Identifiable where Self: UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
}

