//
//  HandleError.swift
//  Example
//
//  Created by SalmoJunior on 8/23/16.
//  Copyright © 2016 Salmo Junior. All rights reserved.
//

import UIKit
import SwiftMessages

/**
 *  Structure responsible to handle and show error to user, both business and technical errors
 */
struct HandleError {
    // MARK: - Public Functions
    
    static func handle(error: Error) {
        
        if let businessError = error as? BusinessError {
            handleBusiness(error: businessError)
        }
        else if let technicalError = error as? TechnicalError {
            handleTechnical(error: technicalError)
        }
    }
    
    // MARK: - Handle Error types
    
    /**
     Handle all types of BusinessError
     
     - parameter error:                BusinessError object
     - parameter navigationController: Instance of current navigationController
     */
    private static func handleBusiness(error: BusinessError) {
        let errorTitle = LocalizableStrings.errorTitle.localize()
        
        switch error {
        case .invalidDictionaryKey(let key):
            let messageError = "\(LocalizableStrings.errorOnParseRequest.localize()) \(key)"
            showDefault(title: errorTitle, description: messageError)
            
        case .invalidValue:
            let messageError = LocalizableStrings.invalidValue.localize()
            showDefault(title: errorTitle, description: messageError)
            
        case .parse(let message):
            let messageError = "\(LocalizableStrings.errorOnParseRequest.localize()) - (\(message))"
            showDefault(title: errorTitle, description: messageError)
        }
    }
    
    /**
     Handle all types of TechnicalError
     
     - parameter error:                TechnicalError object
     - parameter navigationController: Instance of current navigationController
     */
    private static func handleTechnical(error: TechnicalError) {
        let errorTitle = LocalizableStrings.errorTitle.localize()
        
        switch error {
        case .httpError(let code):
            let messageError = "\(LocalizableStrings.httpError.localize()) \(code)"
            showStatusLine(title: errorTitle, description: messageError)
            
        case .invalidURL:
            let messageError = LocalizableStrings.httpError.localize()
            showStatusLine(title: errorTitle, description: messageError)

        case .notFound:
            let messageError = LocalizableStrings.unexpectedError.localize()
            showStatusLine(title: errorTitle, description: messageError)
            
        case .parse(let message):
            let messageError = "\(LocalizableStrings.errorOnParseRequest.localize()) - (\(message))"
            showStatusLine(title: errorTitle, description: messageError)
            
        case .requestError:
            let messageError = LocalizableStrings.httpError.localize()
            showStatusLine(title: errorTitle, description: messageError)
        
        case .notConnected:
            let messageError = LocalizableStrings.notConnected.localize()
            showStatusLine(title: errorTitle, description: messageError)
        }
    }
    
    // MARK: - Present Error types
    
    private static func showDefault(title: String, description: String) {
        // View setup
        let view = MessageView.viewFromNib(layout: .MessageView)
        
        view.configureContent(title: title, body: description, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })
        view.configureTheme(.info, iconStyle: .default)
        
        // Config setup
        var config = SwiftMessages.Config()
        
        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.preferredStatusBarStyle = .lightContent
        
        // Show
        SwiftMessages.show(config: config, view: view)
    }
    
    private static func showStatusLine(title: String, description: String) {
        // View setup
        let view = MessageView.viewFromNib(layout: .StatusLine)

        view.configureContent(title: title, body: description, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })
        view.configureTheme(.info, iconStyle: .light)
        
        // Config setup
        var config = SwiftMessages.Config()
        
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .seconds(seconds: 3)
        config.dimMode = .gray(interactive: false)
        config.preferredStatusBarStyle = .lightContent
        
        // Show
        SwiftMessages.show(config: config, view: view)
    }
}
