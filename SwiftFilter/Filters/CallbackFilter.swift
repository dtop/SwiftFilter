//
//  CallbackFilter.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 19.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import Foundation

public class CallbackFilter: FilterProtocol {
    
    public var callback: ((value: Any?) -> (Any?))?
    
    public required init(@noescape _ initialize: (CallbackFilter) -> Void = { _ in }) {
        
        initialize(self)
    }
    
    public func filter<I: Any, O: Any>(value: I?, _ context: [String : AnyObject]?) throws -> O? {
        
        guard let cb: ((value: Any?) -> (Any?)) = self.callback else {
            return nil
        }
        
        return cb(value: value) as? O
    }
}