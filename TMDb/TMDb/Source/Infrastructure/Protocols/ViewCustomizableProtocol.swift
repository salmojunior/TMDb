//
//  ViewCustomizableProtocol.swift
//  TMDb
//
//  Created by SalmoJunior on 14/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import UIKit

/// Protocol to specifiy when a controller has a mainView with a custom class
/// use with typealias = <CustomView>
protocol ViewCustomizable : class {
    associatedtype MainView
}

extension ViewCustomizable where Self : UIViewController {
    var mainView: MainView {
        guard let mainView = self.view as? MainView else { fatalError("Something went wrong casting view") }
        return mainView
    }
}
