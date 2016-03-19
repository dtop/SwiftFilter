//
//  CallbackFilterTests.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 19.03.16.
//  Copyright © 2016 nerdsee. All rights reserved.
//

import XCTest
@testable import SwiftFilter

class CallbackFilterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFilterCanExecuteCallback() {
        
        let inValue = 634
        let filter = CallbackFilter {
            $0.callback = {
                (value) -> Any in

                guard let myInt: Int = value as? Int else {
                    throw NSError(domain: "my.error.domain", code: 1, userInfo: [NSLocalizedDescriptionKey: "value is not an integer"])
                }
                
                let otherInt = myInt + 66
                return otherInt
            }
        }
        
        do {
            
            let outValue: Int? = try filter.filter(inValue, nil)
            XCTAssertEqual(outValue, 700)
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testFilterCallbackCanThrow() {
        
        let inValue = "LoL"
        let filter = CallbackFilter {
            $0.callback = {
                (value) -> Any in
                
                guard let myInt: Int = value as? Int else {
                    throw NSError(domain: "my.error.domain", code: 1, userInfo: [NSLocalizedDescriptionKey: "value is not an integer"])
                }
                
                let otherInt = myInt + 66
                return otherInt
            }
        }
        
        do {
            
            let outValue: Int? = try filter.filter(inValue, nil)
            XCTAssert(false) // may never be reached
            XCTAssertEqual(outValue, nil) // avoids annoying unused var warning
        } catch let err as NSError {
            
            XCTAssertEqual(err.localizedDescription, "value is not an integer")
        }
    }
    
    func testFilterThrowsIfNoCallbackIsGiven() {
        
        let inValue = "LoL"
        let filter = CallbackFilter()
        
        do {
            
            let outValue: String? = try filter.filter(inValue, nil)
            XCTAssert(false) // may never be reached
            XCTAssertEqual(outValue, nil) // avoids annoying unused var warning
        } catch let err as NSError {
            
            XCTAssertEqual(err.localizedDescription, "No callback given for CallbackFilter")
        }
    }
}
