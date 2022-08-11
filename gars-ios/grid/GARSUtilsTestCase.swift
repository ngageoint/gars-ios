//
//  GARSUtilsTestCase.swift
//  gars-iosTests
//
//  Created by Brian Osborn on 8/11/22.
//

import XCTest
@testable import gars_ios

/**
 * GARS Utils Test
 */
class GARSUtilsTestCase: XCTestCase {

    /**
     * Test latitude band number values
     */
    func testBandValue() {
        
        XCTAssertEqual(1, GARSUtils.bandValue("A" as Character))
        XCTAssertEqual(24, GARSUtils.bandValue("Z" as Character))
        XCTAssertEqual(1, GARSUtils.bandValue("AA"))
        XCTAssertEqual(360, GARSUtils.bandValue("QZ"))
        
    }
    
    /**
     * Test latitude band letters
     */
    func testBandLetters() {
        
        XCTAssertEqual("A", GARSUtils.bandLetter(1))
        XCTAssertEqual("Z", GARSUtils.bandLetter(24))
        XCTAssertEqual("AA", GARSUtils.bandLetters(1))
        XCTAssertEqual("AZ", GARSUtils.bandLetters(24))
        XCTAssertEqual("BA", GARSUtils.bandLetters(25))
        XCTAssertEqual("PZ", GARSUtils.bandLetters(336))
        XCTAssertEqual("QA", GARSUtils.bandLetters(337))
        XCTAssertEqual("QZ", GARSUtils.bandLetters(360))
        
    }
    
    /**
     * Test quadrants
     */
    func testQuadrant() {
        
        XCTAssertEqual(1, GARSUtils.quadrant(0, 1))
        XCTAssertEqual(2, GARSUtils.quadrant(1, 1))
        XCTAssertEqual(3, GARSUtils.quadrant(0, 0))
        XCTAssertEqual(4, GARSUtils.quadrant(1, 0))
        
    }
    
    /**
     * Test keypad
     */
    func testKeypad() {
        
        XCTAssertEqual(1, GARSUtils.keypad(0, 2))
        XCTAssertEqual(2, GARSUtils.keypad(1, 2))
        XCTAssertEqual(3, GARSUtils.keypad(2, 2))
        XCTAssertEqual(4, GARSUtils.keypad(0, 1))
        XCTAssertEqual(5, GARSUtils.keypad(1, 1))
        XCTAssertEqual(6, GARSUtils.keypad(2, 1))
        XCTAssertEqual(7, GARSUtils.keypad(0, 0))
        XCTAssertEqual(8, GARSUtils.keypad(1, 0))
        XCTAssertEqual(9, GARSUtils.keypad(2, 0))
        
    }
    
}
