//
//  ReplaceFilterTests.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 18.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import XCTest
@testable import SwiftFilter

class ReplaceFilterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFilterCanReplaceStringProperly() {
        
        let inValue = "this is the moo sentence. It requires a lot of moo and also >>>moo<<<"
        
        let filter = ReplaceFilter {
            $0.replaceType = .ReplaceString(searchStr: "moo", replacementStr: "abc")
        }
        
        do {
            
            let outValue: String? = try filter.filter(inValue, nil)
            XCTAssertEqual(outValue, "this is the abc sentence. It requires a lot of abc and also >>>abc<<<")
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testFilterCanReplaceRange() {
        
        let inValue = "The quick brown fox jumps over the lazy dog"
        
        let filter = ReplaceFilter {
            $0.replaceType = .ReplaceRange(advStart: 4, advEnd: 9, replacementStr: "lightning fast")
        }
        
        do {
            
            let outValue: String? = try filter.filter(inValue, nil)
            XCTAssertEqual(outValue, "The lightning fast brown fox jumps over the lazy dog")
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testFilterCanHandleOddInput() {
        
        let filter = ReplaceFilter {
            $0.replaceType = .ReplaceString(searchStr: "", replacementStr: "")
        }
        let moo: Any? = nil
        
        do {
            
            var outValue: String?
            
            outValue = try filter.filter(0, nil)
            XCTAssertEqual(outValue, nil)
            
            outValue = try filter.filter(moo, nil)
            XCTAssertEqual(outValue, nil)
            
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testFilterThrowsIfNoReplaceTypeIsGiven() {
     
        let inString = "test"
        let filter = ReplaceFilter()
        
        do {
            
            let outString: String? = try filter.filter(inString, nil)
            XCTAssert(false) // may never be reached
            XCTAssertEqual(outString, nil) // needed for annoying unused msg
        } catch let err as NSError {
            
            XCTAssertEqual(err.localizedDescription, "No replacementType given in ReplaceFilter")
        }
    }
}
