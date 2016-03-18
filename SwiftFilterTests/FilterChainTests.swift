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
        
        chain <- CharCaseFilter {
            $0.charCase = .lowercase
        }
        
    }
}
