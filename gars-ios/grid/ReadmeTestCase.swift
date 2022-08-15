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

        let grids = Grids()

        let zoomGrids = grids.grids(tile.zoom)
        if (zoomGrids.hasGrids()) {

            for grid in zoomGrids {

                let lines = grid.lines(tile)
                if (lines != nil) {
                    for line in lines! {
                        let pixel1 = line.point1.pixel(tile)
                        let pixel2 = line.point2.pixel(tile)
                        // Draw line
                    }
                }

                let labels = grid.labels(tile)
                if (labels != nil) {
                    for label in labels! {
                        let pixelRange = label.bounds.pixelRange(tile)
                        let centerPixel = label.center.pixel(tile)
                        // Draw label
                    }
                }

            }
        }
        
    }
    
}
