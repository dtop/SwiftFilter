//
//  ReplaceFilter.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 18.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import Foundation

public class ReplaceFilter: FilterProtocol {
    
    public enum ReplaceType {
        case ReplaceString(searchStr: String, replacementStr: String)
        case ReplaceRange(advStart: Int, advEnd: Int, replacementStr: String)
    }
    
    /// Holds the actual replacement type
    public var replaceType: ReplaceType!
    
    /**
     Easy init
     
     - parameter initialize: the initializer func
     */
    required public init(@noescape _ initialize: (ReplaceFilter) -> Void = { _ in }) {
        
        initialize(self)
    }
    
    /// should return the input when filter fails otherwise nil
    public var returnInputOnFailure: Bool = true
    
    /**
     Filters a value
     
     - parameter value:   the value
     - parameter context: some context
     
     - throws: filter errors
     
     - returns: the filtered value
     */
    public func filter<I: Any, O: Any>(value: I?, _ context: [String: AnyObject]?) throws -> O? {
        
        guard let rType: ReplaceType = self.replaceType else {
            throw NSError(domain: swiftFilterErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: "No replacementType given in ReplaceFilter"])
        }
        
        guard var inStr: String = value as? String else {
            return nil
        }
        
        switch rType {
            
        case let .ReplaceString(searchString, replacementStr):
            return inStr.stringByReplacingOccurrencesOfString(searchString, withString: replacementStr) as? O
            
        case let .ReplaceRange(advStart, advEnd, replacementStr):
            inStr.replaceRange(Range<String.Index>(start: inStr.startIndex.advancedBy(advStart), end: inStr.startIndex.advancedBy(advEnd)), with: replacementStr)
            return inStr as? O
        }
    }
}
