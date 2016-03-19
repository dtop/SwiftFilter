//
//  FilterProtocols.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 11.03.16.
//  Copyright © 2016 Danilo Topalovic. All rights reserved.
//

import Foundation

public let swiftFilterErrorDomain = "de.nerdsee.SwiftFilter.Error"

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

infix operator <~~ { associativity left precedence 100 }

func <~~ <T: FilterProtocol>(lhs: FilterChain, rhs: T) -> FilterChain {
    
    lhs.registerFilter(rhs)
    return lhs
}
