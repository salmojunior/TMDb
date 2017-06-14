//
//  ReachabilityExtension.swift
//  TMDb
//
//  Created by SalmoJunior on 13/05/17.
//  Copyright © 2017 Salmo Junior. All rights reserved.
//

import Reachability

extension Reachability {
    // MARK: - Private Computed Properties
    private static let defaultHost = "www.google.com"
    private static var reachability = Reachability(hostName: defaultHost)
    
    // MARK: - Public Functions
    
    /// True value if there is a stable network connection
    static var isConnected: Bool {
        guard let reachability = Reachability.reachability else { return false }
        
        return reachability.currentReachabilityStatus() != .NotReachable
    }
    
    /// Current network status based on enum NetworkStatus
    static var status: NetworkStatus {
        guard let reachability = Reachability.reachability else { return .NotReachable }
        
        return reachability.currentReachabilityStatus()
    }
}
