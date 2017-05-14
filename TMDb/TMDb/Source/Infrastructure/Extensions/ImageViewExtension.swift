//
//  ImageViewExtension.swift
//  CITAppStore
//
//  Created by SalmoJunior on 21/02/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Make a safe copy of UIImageView
    ///
    /// - Returns: clone of current UIImageView
    func clone() -> UIImageView {
        
        let cloneImageView = UIImageView(image: self.image)
        cloneImageView.frame = self.frame
        cloneImageView.clipsToBounds = self.clipsToBounds
        cloneImageView.contentMode = self.contentMode
        cloneImageView.isOpaque = self.isOpaque
        cloneImageView.layer.cornerRadius = self.layer.cornerRadius
        
        return cloneImageView
    }
}
