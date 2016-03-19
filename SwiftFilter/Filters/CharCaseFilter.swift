//
//  CharCaseFilter.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 11.03.16.
//  Copyright © 2016 Danilo Topalovic. All rights reserved.
//

import Foundation

public class CharCaseFilter: FilterProtocol {
    
    /**
     Possible char cases
     
     - lowercase: all letters lowercase
     - uppercase: all letters uppercase
     - ucfirst:   only first letter upper, rest lower
     - ucwords:   all words separated by space goes ucfirst
     */
    public enum Case {
        case Lowercase
        case Uppercase
        case Ucfirst
        case Ucwords
    }
    
    /// the filtering char case
    public var charCase: Case!
    
    // MARK: FilterProtocol
    
    required public init(@noescape _ initialize: (CharCaseFilter) -> Void = { _ in }) {
        
        initialize(self)
    }
    
    public func filter<I: Any, O: Any>(value: I?, _ context: [String : AnyObject]?) throws -> O? {
        
        guard let cCase: Case = self.charCase else {
            throw NSError(domain: swiftFilterErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: "No case convert mode set in CharCaseFilter"])
        }
        
        guard let value: String = value as? String else {
            return nil
        }
        
        if value.isEmpty {
            return nil
        }
        
        var returnValue = ""
        
        switch cCase {
        case .Lowercase:
            returnValue = value.lowercaseString
            break
        case .Uppercase:
            returnValue = value.uppercaseString
            break
        case .Ucfirst:
            returnValue = self.ucfirst(value)
            break
        case .Ucwords:
            returnValue = value.capitalizedString
            break
        }
        
        return returnValue as? O
    }
    
    /**
     Turns only the first letter to capital, the rest is lowercase
     
     - parameter str: the str to change
     
     - returns: the ucfirst string
     */
    private func ucfirst(str: String) -> String {
        
        var lower = str.lowercaseString
        let char  = "\(lower.characters.first!)"
        
        lower.replaceRange(Range<String.Index>(start: lower.startIndex, end: lower.startIndex.advancedBy(1)), with: char.uppercaseString)
        return lower
    }
    
    
}
