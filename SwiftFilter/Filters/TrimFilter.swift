//
//  TrimFilter.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 18.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import Foundation

public class TrimFilter: FilterProtocol {
    
    // MARK: FilterProtocol
    
    public required init(@noescape _ initialize: (TrimFilter) -> Void = { _ in }) {
        
        initialize(self)
    }
    
    public func filter<I: Any, O: Any>(value: I?, _ context: [String : AnyObject]?) throws -> O? {
        
        guard let inStr: String = value as? String else {
            return nil
        }
        
        let trimmed = inStr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return trimmed as? O
    }
}
