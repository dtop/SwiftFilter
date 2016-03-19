//
//  TrimFilterTests.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 19.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import XCTest
@testable import SwiftFilter

class TrimFilterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFilterCanTrimWhitespace() {
        
        let inString: String = "  \t\t  Sentence with \n whitespace around  \n \t  \n  "
        let filter   = TrimFilter()
        
        do {
            
            let outString: String? = try filter.filter(inString, nil)
            XCTAssertEqual(outString, "Sentence with \n whitespace around")
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testFilterCanHandleOddInputs() {
        
        let inString: String? = nil
        let filter   = TrimFilter()
        
        do {
            
            let outString: String? = try filter.filter(inString, nil)
            XCTAssertEqual(outString, nil)
        } catch _ {
            XCTAssert(false)
        }
    }
}
