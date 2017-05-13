//
//  BaseManager.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Foundation

class BaseManager {
    
    //MARK: Properties
    var operations: OperationQueue
    
    //MARK: Initializers
    
    /**
     Initialize an BaseManager subclass.
     
     - returns: an instance of BaseManager subclass.
     */
    init() {
        operations = OperationQueue()
    }
    
    /**
     Initialize an BaseManager subclass.
     
     - parameter maxConcurrentOperationCount: maximun number of concurrent operations.
     
     - returns: an instance of BaseManager subclass.
     */
    convenience init(maxConcurrentOperationCount: Int) {
        self.init()
        
        operations.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
    
    //MARK: Deinitalizers
    
    deinit {
        operations.cancelAllOperations()
    }
}
