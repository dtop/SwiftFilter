//
//  RegexReplaceFilterTests.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 19.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import XCTest
@testable import SwiftFilter

class RegexReplaceFilterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFilterCanReplaceOccurencesOfString() {
        
        let inString: String? = "LoL 1323423 this is a 234234 string with 89803458 a lot 879080 of numbers in it 89"
        let filter = RegexReplaceFilter {
            $0.pattern = "([0-9]+)"
            $0.replacement = ""
        }
     
        do {
            
            let outString: String? = try filter.filter(inString, nil)
            XCTAssertEqual(outString, "LoL  this is a  string with  a lot  of numbers in it ")
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testFilterCanHandleOddInputs() {
        
        let inString: String? = nil
        let filter = RegexReplaceFilter {
            $0.pattern = "([0-9]+)"
            $0.replacement = ""
        }
        
        do {
            
            let outString: String? = try filter.filter(inString, nil)
            XCTAssertEqual(outString, nil)
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testFilterThrowsOnMissingPatternOrReplacement() {
        
        let inString = "test"
        let filter = RegexReplaceFilter()
        
        do {
            
            let outString: String? = try filter.filter(inString, nil)
            XCTAssert(false) // may never be reached
            XCTAssertEqual(outString, nil) // needed for annoying unused msg
        } catch let err as NSError {
            
            XCTAssertEqual(err.localizedDescription, "No pattern or no replacement given in RegexReplaceFilter")
        }
    }
}
