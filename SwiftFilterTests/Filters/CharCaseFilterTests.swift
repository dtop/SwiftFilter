//
//  CharCaseFilterTests.swift
//  SwiftFilter
//
//  Created by Danilo Topalovic on 11.03.16.
//  Copyright © 2016 Danilo Topalovic. All rights reserved.
//

import XCTest
@testable import SwiftFilter

class CharCaseFilterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCharCaseFilterModifiesCaseUpperAndLower() {
        
        let filter = CharCaseFilter {
            $0.charCase = .lowercase
        }
        
        do {
            
            guard let result: String = try filter.filter("MOO", nil) else {
                throw NSError(domain: "could not filter", code: 0, userInfo: nil)
            }
            
            XCTAssertEqual(result, "moo")
            
            filter.charCase = .uppercase
            
            guard let result2: String = try filter.filter("moo", nil) else {
                throw NSError(domain: "could not filter", code: 0, userInfo: nil)
            }
            
            XCTAssertEqual(result2, "MOO")
            
        } catch _ {
            XCTAssert(false)
        }
    }
    
    func testCharCaseFilterCanUcfirst() {
        
        let filter = CharCaseFilter {
            $0.charCase = .ucfirst
        }
        
        do {
            
            guard let result: String = try filter.filter("dAs IsT DAS haus vom Nikolaus, da schaut er RAUS dEr alTe kLAUS", nil) else {
                throw NSError(domain: "could not filter", code: 0, userInfo: nil)
            }
            
            XCTAssertEqual(result, "Das ist das haus vom nikolaus, da schaut er raus der alte klaus")
            
        } catch _ {
            
            XCTAssert(false)
        }
    }
    
    func testCharCaseFilterCanUcWords() {
        
        let filter = CharCaseFilter {
            $0.charCase = .ucwords
        }
        
        do {
            
            guard let result: String = try filter.filter("dAs IsT DAS haus vom Nikolaus, da schaut er RAUS dEr alTe kLAUS", nil) else {
                throw NSError(domain: "could not filter", code: 0, userInfo: nil)
            }
            
            XCTAssertEqual(result, "Das Ist Das Haus Vom Nikolaus, Da Schaut Er Raus Der Alte Klaus")
            
        } catch _ {
            
            XCTAssert(false)
        }
    }
    
    func testCharCaseFilterCanHandleOddValues() {
        
        let filter = CharCaseFilter()
        let nilValue: String? = nil
        var result: String? = nil
        
        do {
            
            result = try filter.filter(nilValue, nil)
            XCTAssertNil(result)
            
            result = try filter.filter(2, nil)
            XCTAssertNil(result)
            
            result = try filter.filter("", nil)
            XCTAssertNil(result)
            
        } catch _ {
            XCTAssert(false)
        }
    }
}