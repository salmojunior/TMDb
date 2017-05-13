//
//  BusinessError.swift
//  Example
//
//  Created by SalmoJunior on 8/17/16.
//  Copyright © 2016 Salmo Junior. All rights reserved.
//

enum BusinessError: Error {
    case parse(String)
    case invalidValue
    case invalidDictionaryKey(String)
}
