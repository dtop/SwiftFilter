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
protocol FilterType {
    
    /**
     Filters a value
     
     - parameter value:   the value
     - parameter context: some context
     
     - throws: filter errors
     
     - returns: the filtered value
     */
    func filter<I: Any, O: Any>(value: I, _ context: [String: AnyObject]?) throws -> O?
}

/**
 *  Protocol for all filter objects
 */
public protocol FilterProtocol {
    
    /**
     Easy init
     
     - parameter initialize: the initializer func
     */
    init(@noescape _ initialize: (Self) -> Void)
    
    /// should return the input when filter fails otherwise nil
    var returnInputOnFailure: Bool { get set }
    
    /**
     Filters a value
     
     - parameter value:   the value
     - parameter context: some context
     
     - throws: filter errors
     
     - returns: the filtered value
     */
    func filter<I: Any, O: Any>(value: I, _ context: [String: AnyObject]?) throws -> O?
}

extension FilterProtocol {
    
    /**
     Returns either the failing value OR nil on failure
     
     - parameter value: the input value
     
     - returns: nil or the input value
     */
    func returnFailingValue<I: Any, O: Any>(value: I) -> O? {
        
        if self.returnInputOnFailure {
            return value as? O
        }
        
        return nil
    }
}
