//
//  ReadmeTestCase.swift
//  gars-iosTests
//
//  Created by Brian Osborn on 8/11/22.
//

import XCTest
@testable import grid_ios
@testable import gars_ios

/**
 * README example tests
 */
class ReadmeTestCase: XCTestCase {

    /**
     * Test GARS coordinates
     */
    func testCoordinates() {
        
        let gars = GARS.parse("006AG39")
        let point = gars.toPoint()
        let pointMeters = point.toMeters()

        let latitude = 63.98862388
        let longitude = 29.06755082
        let point2 = GridPoint(longitude, latitude)
        let gars2 = GARS.from(point2)
        let garsCoordinate = gars2.description
        let gars30m = gars2.coordinate(GridType.THIRTY_MINUTE)
        let gars15m = gars2.coordinate(GridType.FIFTEEN_MINUTE)
        let gars5m = gars2.coordinate(GridType.FIVE_MINUTE)
        
    }

    /**
     * Test draw tile template logic
     */
    func testDrawTile() {
        ReadmeTestCase.testDrawTile(GridTile(512, 512, 8, 12, 5))
    }
    
    /**
     * Test draw tile template logic
     *
     * @param tile
     *            grid tile
     */
    private static func testDrawTile(_ tile: GridTile) {
        
        // let tile: GridTile = ...
        
        // TODO
        
    }
    
}
