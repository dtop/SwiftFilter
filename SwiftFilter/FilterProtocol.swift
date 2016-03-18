//
//  FilterProtocols.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 11.03.16.
//  Copyright © 2016 Danilo Topalovic. All rights reserved.
//

import Foundation

/**
 * Protocol to use generical filters
 */
public protocol FilterType {
    
    /**
     Filters a value
     
     - parameter value:   the value
     - parameter context: some context
     
     - throws: filter errors
     
     - returns: the filtered value
     */
    func filter<I: Any, O: Any>(value: I?, _ context: [String: AnyObject]?) throws -> O?
}

/**
 *  Protocol for all filter objects
 */
public protocol FilterProtocol: FilterType {
    
    /**
     Easy init
     
     - parameter initialize: the initializer func
     */
    init(@noescape _ initialize: (Self) -> Void)
}
