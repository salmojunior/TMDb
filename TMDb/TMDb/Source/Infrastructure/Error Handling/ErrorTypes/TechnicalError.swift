//
//  TechnicalError.swift
//  Example
//
//  Created by SalmoJunior on 8/17/16.
//  Copyright © 2016 Salmo Junior. All rights reserved.
//

enum TechnicalError: Error {
    case parse(String)
    case httpError(Int)
    case requestError
    case invalidURL
    case notFound
    case notConnected
}
