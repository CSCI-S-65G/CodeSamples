//
//  TwoDimensionalSampleCodeTests.swift
//  TwoDimensionalSampleCodeTests
//
//  Created by Jp LaFond on 7/2/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import XCTest
@testable import TwoDimensionalSampleCode

class TwoDimensionalSampleCodeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - The TwoDimensional Tests
    func testNegativeColumnRowMaxes() {
        let twoDim0Col0Row = TwoDimensional(columns: -10, rows: -10)
        XCTAssertTrue(twoDim0Col0Row.columnsMax == 0,
                      "We expect that the negative column will be " +
                        "normalized <\(twoDim0Col0Row.columnsMax)>")
        XCTAssertTrue(twoDim0Col0Row.rowsMax == 0,
                      "We expect that the negative row will be " +
                        "normalized <\(twoDim0Col0Row.rowsMax)>")
    }

    func testPositiveColumnRowMaxes() {
        let expectedColumnValue = 7
        let expectedRowValue = 3

        let twoDim0Col0Row = TwoDimensional(columns: expectedColumnValue,
                                            rows: expectedRowValue)
        XCTAssertTrue(twoDim0Col0Row.columnsMax == expectedColumnValue,
                      "We expect that the negative column will be " +
                        "normalized <\(twoDim0Col0Row.columnsMax)>")
        XCTAssertTrue(twoDim0Col0Row.rowsMax == expectedRowValue,
                      "We expect that the negative row will be " +
                        "normalized <\(twoDim0Col0Row.rowsMax)>")
    }
    
}
