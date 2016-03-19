//
//  FilterChainTests.swift
//  FilterChainTests
//
//  Created by Danilo Topalovic on 18.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import XCTest
@testable import SwiftFilter

class FilterChainTests: XCTestCase {
    

    func testFilterChainCanAcceptAllFilters() {
        
        let chain = FilterChain()
        
        chain <~~ CallbackFilter()
        chain <~~ CharCaseFilter {
            $0.charCase = .Lowercase
        }
        
        chain <~~ ReplaceFilter()
        chain <~~ TrimFilter()
        chain <~~ RegexReplaceFilter()
        
    }
    
    func testFilterChainCanFilter() {
        
        let input: String = "  \t\t  Hi there, this is a 99test String "
        let chain = FilterChain()
            <~~ TrimFilter()
            <~~ RegexReplaceFilter {
                $0.pattern = "([0-9]+)"
                $0.replacement = ""
            }
        
        do {
            
            let outString: String? = try chain.filter(input, nil)
            XCTAssertEqual(outString, "Hi there, this is a test String")
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testFilterChainAbbortsOnNilReturnment() {
        
        let input: Int = 34
        let chain = FilterChain()
            <~~ TrimFilter()
            <~~ RegexReplaceFilter {
                $0.pattern = "([0-9]+)"
                $0.replacement = ""
        }
        
        do {
            
            let outString: String? = try chain.filter(input, nil)
            XCTAssertEqual(outString, nil)
        } catch _ {
            XCTAssert(false)
        }
    }
}
