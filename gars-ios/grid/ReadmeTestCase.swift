//
//  ReadmeTestCase.swift
//  gars-iosTests
//
//  Created by Brian Osborn on 8/11/22.
//

import XCTest
@testable import grid_ios
@testable import gars_ios
import MapKit

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
     * Test tile overlay
     */
    func testTileOverlay() {
        
        // let mapView: MKMapView = ...

        // Tile size determined from display density
        let tileOverlay = GARSTileOverlay()

        // Manually specify tile size
        let tileOverlay2 = GARSTileOverlay(512, 512)

        // Specified grids
        let customTileOverlay = GARSTileOverlay(
                [GridType.THIRTY_MINUTE, GridType.FIFTEEN_MINUTE])

        //mapView.addOverlay(tileOverlay)
        
    }
    
    /**
     * Test tile provider options
     */
    func testOptions() {

        let tileOverlay = GARSTileOverlay()

        let x = 8
        let y = 12
        let zoom = 5

        // Manually get a tile or draw the tile bitmap
        let tile = tileOverlay.tile(x, y, zoom)
        let tileImage = tileOverlay.drawTile(x, y, zoom)

        let latitude = 63.98862388
        let longitude = 29.06755082
        let locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude)

        // GARS Coordinates
        let gars = tileOverlay.gars(locationCoordinate)
        let coordinate = tileOverlay.coordinate(locationCoordinate)
        let zoomCoordinate = tileOverlay.coordinate(locationCoordinate, zoom)

        let gars30m = tileOverlay.coordinate(locationCoordinate, GridType.THIRTY_MINUTE)
        let gars15m = tileOverlay.coordinate(locationCoordinate, GridType.FIFTEEN_MINUTE)
        let gars5m = tileOverlay.coordinate(locationCoordinate, GridType.FIVE_MINUTE)
        
    }
    
    /**
     * Test custom grids
     */
    func testCustomGrids() {

        let grids = Grids()

        grids.deletePropagatedStyles()
        grids.disableTypes([GridType.TWENTY_DEGREE, GridType.TEN_DEGREE,
                GridType.FIVE_DEGREE, GridType.ONE_DEGREE])

        grids.setColor(GridType.THIRTY_MINUTE, UIColor.red)
        grids.setWidth(GridType.THIRTY_MINUTE, 4.0)
        grids.setMinZoom(GridType.THIRTY_MINUTE, 6)

        grids.setLabelMinZoom(GridType.THIRTY_MINUTE, 6)
        grids.setLabelTextSize(GridType.THIRTY_MINUTE, 32.0)

        grids.setColor(GridType.FIFTEEN_MINUTE, UIColor.blue)
        let lessThan15m = GridType.lessPrecise(GridType.FIFTEEN_MINUTE)
        grids.setWidth(GridType.FIFTEEN_MINUTE, lessThan15m, 4.0)
        grids.setColor(GridType.FIFTEEN_MINUTE, lessThan15m, UIColor.red)

        grids.setLabelColor(GridType.FIVE_MINUTE, UIColor.orange)
        grids.setLabelBuffer(GridType.FIVE_MINUTE, 0.1)
        grids.setWidth(GridType.FIVE_MINUTE, lessThan15m, 4.0)
        grids.setColor(GridType.FIVE_MINUTE, lessThan15m, UIColor.red)
        grids.setColor(GridType.FIVE_MINUTE, GridType.FIFTEEN_MINUTE, UIColor.blue)

        let tileOverlay = GARSTileOverlay(grids)

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
