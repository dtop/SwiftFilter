//
//  RegexReplaceFilter.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 19.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import Foundation

public class RegexReplaceFilter: FilterProtocol {
    
    /// the pattern to be matched against
    public var pattern: String!
    
    /// expression options
    public var options: NSRegularExpressionOptions = NSRegularExpressionOptions(rawValue: 0)
    
    /// matching options
    public var matchingOptions: NSMatchingOptions = NSMatchingOptions(rawValue: 0)
    
    /// the replacement
    public var replacement: String!
    
    // MARK: FilterProtocol
    
    public required init(@noescape _ initialize: (RegexReplaceFilter) -> Void = { _ in }) {
        
        initialize(self)
    }
    
    public func filter<I: Any, O: Any>(value: I?, _ context: [String: AnyObject]?) throws -> O? {
        
        guard let pattern: String = self.pattern, let replacement: String = self.replacement else {
            throw NSError(domain: swiftFilterErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: "No pattern or no replacement given in RegexReplaceFilter"])
        }
        
        guard let inStr: String = value as? String else {
            return nil
        }
        
        let regex = try NSRegularExpression(pattern: pattern, options: self.options)
        let outStr = regex.stringByReplacingMatchesInString(inStr, options: self.matchingOptions, range: NSRange(0..<inStr.utf16.count), withTemplate: replacement)
        
        return outStr as? O
    }
}
