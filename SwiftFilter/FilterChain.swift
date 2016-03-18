//
//  FilterContainer.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 11.03.16.
//  Copyright © 2016 Danilo Topalovic. All rights reserved.
//

import Foundation

/**
 * Allows to attach filter to a 
 * chain that can be used for a single value
 */
class FilterChain: FilterProtocol {
    
    typealias F = FilterType
    
    /// Holds all filters that will be applied
    var filters: [F] = []
    
    var returnInputOnFailure: Bool = true
    
    required init(@noescape _ initialize: (FilterChain) -> Void = { _ in }) {
        
        initialize(self)
    }
    
    /**
     Registers a FIlter to the chain
     
     - parameter filter: the filter
     */
    func registerFilter(filter: F) {
        
        self.filters.append(filter)
    }
    
    // MARK: FilterProtocol
    
    func filter<I: Any, O: Any>(value: I, _ context: [String : AnyObject]? = nil) throws -> O? {
        
        var val: O? = nil
        for filter in filters {
            
            val = try filter.filter(value, context)
        }
        
        return val ?? value as? O
    }
}
