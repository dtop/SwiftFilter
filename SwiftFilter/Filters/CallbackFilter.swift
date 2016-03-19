//
//  CallbackFilter.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 19.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import Foundation

public class CallbackFilter: FilterProtocol {
    
    /// holds the actual callback
    public var callback: ((Any?) throws -> (Any?))?
    
    // MARK: FilterProtocol
    
    public required init(@noescape _ initialize: (CallbackFilter) -> Void = { _ in }) {
        
        initialize(self)
    }
    
    public func filter<I: Any, O: Any>(value: I?, _ context: [String : AnyObject]?) throws -> O? {
        
        guard let cb: ((Any?) throws -> (Any?)) = self.callback else {
            throw NSError(domain: swiftFilterErrorDomain, code: 1, userInfo: [NSLocalizedDescriptionKey: "No callback given for CallbackFilter"])
        }
        
        return try cb(value) as? O
    }
}
