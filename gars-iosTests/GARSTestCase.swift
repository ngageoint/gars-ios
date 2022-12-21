//
//  GARSTestCase.swift
//  gars-iosTests
//
//  Created by Brian Osborn on 8/11/22.
//

import XCTest
@testable import grid_ios
@testable import gars_ios
@testable import sf_ios

/**
 * GARS Test
 */
class GARSTestCase: XCTestCase {

    /**
     * Test parsing a GARS string value
     */
    func testParse() {
        
        var garsValue = "001AA"
        XCTAssertTrue(GARS.isGARS(garsValue))
        var gars = GARS.parse(garsValue)
        XCTAssertEqual(1, gars.longitude)
        XCTAssertEqual("AA", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        var point = gars.toPoint()
        XCTAssertEqual(-180.0, point.longitude, accuracy: 0)
        XCTAssertEqual(-90.0, point.latitude, accuracy: 0)
        var gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "001AW"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(1, gars.longitude)
        XCTAssertEqual("AW", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(-180.0, point.longitude, accuracy: 0)
        XCTAssertEqual(-80.0, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "001QZ"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(1, gars.longitude)
        XCTAssertEqual("QZ", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(-180.0, point.longitude, accuracy: 0)
        XCTAssertEqual(89.5, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "001QD"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(1, gars.longitude)
        XCTAssertEqual("QD", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(-180.0, point.longitude, accuracy: 0)
        XCTAssertEqual(79.5, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "720AA"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(720, gars.longitude)
        XCTAssertEqual("AA", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(179.5, point.longitude, accuracy: 0)
        XCTAssertEqual(-90.0, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "720AW"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(720, gars.longitude)
        XCTAssertEqual("AW", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(179.5, point.longitude, accuracy: 0)
        XCTAssertEqual(-80.0, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "720QZ"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(720, gars.longitude)
        XCTAssertEqual("QZ", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(179.5, point.longitude, accuracy: 0)
        XCTAssertEqual(89.5, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "720QD"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(720, gars.longitude)
        XCTAssertEqual("QD", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(179.5, point.longitude, accuracy: 0)
        XCTAssertEqual(79.5, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "006AG"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(6, gars.longitude)
        XCTAssertEqual("AG", gars.latitude)
        XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(-177.5, point.longitude, accuracy: 0)
        XCTAssertEqual(-87.0, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_QUADRANT)
                       + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "006AG3"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(6, gars.longitude)
        XCTAssertEqual("AG", gars.latitude)
        XCTAssertEqual(3, gars.quadrant)
        XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(-177.5, point.longitude, accuracy: 0)
        XCTAssertEqual(-87.0, point.latitude, accuracy: 0)
        gars2 = GARS.from(point)
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue + String(GARSConstants.DEFAULT_KEYPAD), gars2.coordinate())
        
        garsValue = "006AG39"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(6, gars.longitude)
        XCTAssertEqual("AG", gars.latitude)
        XCTAssertEqual(3, gars.quadrant)
        XCTAssertEqual(9, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(-177.3333333, point.longitude, accuracy: 0.000001)
        XCTAssertEqual(-87.0, point.latitude, accuracy: 0)
        gars2 = GARS.from(GridPoint(point.longitude + 0.000001, point.latitude))
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue, gars2.coordinate())
        
        garsValue = "006AG25"
        XCTAssertTrue(GARS.isGARS(garsValue))
        gars = GARS.parse(garsValue)
        XCTAssertEqual(6, gars.longitude)
        XCTAssertEqual("AG", gars.latitude)
        XCTAssertEqual(2, gars.quadrant)
        XCTAssertEqual(5, gars.keypad)
        point = gars.toPoint()
        XCTAssertEqual(-177.1666667, point.longitude, accuracy: 0.000001)
        XCTAssertEqual(-86.6666667, point.latitude, accuracy: 0.000001)
        gars2 = GARS.from(GridPoint(point.longitude, point.latitude + 0.000001))
        XCTAssertEqual(gars, gars2)
        XCTAssertEqual(garsValue, gars2.coordinate())
        
    }
    
    /**
     * Test parsing an invalid GARS string value
     */
    func testParseInvalid() {
        
        XCTAssertFalse(GARS.isGARS("1AA"))
        XCTAssertFalse(GARS.isGARS("01AA"))
        XCTAssertFalse(GARS.isGARS("001A"))
        XCTAssertFalse(GARS.isGARS("000AA"))
        XCTAssertFalse(GARS.isGARS("721AA"))
        XCTAssertFalse(GARS.isGARS("001RA"))
        XCTAssertFalse(GARS.isGARS("720ZZ"))
        XCTAssertFalse(GARS.isGARS("000AG3"))
        XCTAssertFalse(GARS.isGARS("721AG3"))
        XCTAssertFalse(GARS.isGARS("006RA3"))
        XCTAssertFalse(GARS.isGARS("006ZZ3"))
        XCTAssertFalse(GARS.isGARS("000AG39"))
        XCTAssertFalse(GARS.isGARS("721AG39"))
        XCTAssertFalse(GARS.isGARS("006RA39"))
        XCTAssertFalse(GARS.isGARS("006ZZ39"))
        XCTAssertFalse(GARS.isGARS("006AG09"))
        XCTAssertFalse(GARS.isGARS("006AG59"))
        XCTAssertFalse(GARS.isGARS("006AG30"))
        XCTAssertFalse(GARS.isGARS("006AG310"))
        
    }
    
    /**
     * Test parsing a GARS string value
     */
    func testCoordinate() {
        
        var gars = "419NV11"
        testCoordinate(29.06757, 63.98863, gars)
        testCoordinateMeters(3235787.09, 9346877.48, gars)

        gars = "468JN14"
        testCoordinate(53.51, 12.40, gars)
        testCoordinateMeters(5956705.95, 1391265.16, gars)

        gars = "045KG17"
        testCoordinate(-157.916861, 21.309444, gars)
        testCoordinateMeters(-17579224.55, 2428814.96, gars)

        gars = "395JE45"
        testCoordinate(17.3714337, 8.1258235, gars)
        testCoordinateMeters(1933779.15, 907610.20, gars)

        gars = "204LQ37"
        testCoordinate(-78.5, 37.0, gars)
        testCoordinateMeters(-8738580.027271975, 4439106.787250587, gars)

        gars = "204LQ27"
        testCoordinate(GridPoint(-78.25, 37.25), gars)
        testCoordinateMeters(-8710750.154573655, 4474011.088229479, gars)

        gars = "204LQ25"
        testCoordinate(-78.16666666, 37.33333334, gars)
        testCoordinateMeters(-8701473.529598756, 4485671.563830873, gars)

        gars = "204LQ23"
        testCoordinate(-78.08333333, 37.41666667, gars)
        testCoordinateMeters(-8692196.905737048, 4497344.980476594, gars)
        
    }
    
    /**
     * Test parsing point bounds
     */
    func testPointBounds() {
        
        // Max latitude tests
        
        var gars = "462RA49"
        var gars2 = "462QZ26"
        var longitude = 50.920338
        var latitudeBelow = 89.9
        var latitudeAbove = 100.0
        
        var point = GridPoint.degrees(longitude, GARSConstants.MAX_LAT)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeBelow)
        XCTAssertEqual(gars2, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeAbove)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        // Max latitude and max longitude tests

        longitude += (2 * SF_WGS84_HALF_WORLD_LON_WIDTH)
        
        point = GridPoint.degrees(longitude, GARSConstants.MAX_LAT)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeBelow)
        XCTAssertEqual(gars2, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeAbove)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        // Max latitude and min longitude tests
        
        longitude -= (4 * SF_WGS84_HALF_WORLD_LON_WIDTH)
        
        point = GridPoint.degrees(longitude, GARSConstants.MAX_LAT)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeBelow)
        XCTAssertEqual(gars2, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeAbove)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        // Min latitude tests
        
        gars = "617AA49"
        gars2 = "617AB49"
        longitude = 128.4525
        latitudeAbove = -89.5
        latitudeBelow = -100.0
        
        point = GridPoint.degrees(longitude, GARSConstants.MIN_LAT)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeAbove)
        XCTAssertEqual(gars2, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeBelow)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        // Max latitude and max longitude tests

        longitude += (2 * SF_WGS84_HALF_WORLD_LON_WIDTH)
        
        point = GridPoint.degrees(longitude, GARSConstants.MIN_LAT)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeAbove)
        XCTAssertEqual(gars2, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeBelow)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        // Max latitude and min longitude tests
        
        longitude -= (4 * SF_WGS84_HALF_WORLD_LON_WIDTH)
        
        point = GridPoint.degrees(longitude, GARSConstants.MIN_LAT)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeAbove)
        XCTAssertEqual(gars2, GARS.from(point).coordinate())
        
        point = GridPoint.degrees(longitude, latitudeBelow)
        XCTAssertEqual(gars, GARS.from(point).coordinate())
        
    }
    
    /**
     * Test parsing 30 minute full range
     */
    func test30MinuteParse() {
        
        let gridRange = GridRange()
        
        var count = 0
        
        var number = GARSConstants.MIN_BAND_NUMBER
        var letters = GARSConstants.MIN_BAND_LETTERS_NUMBER
        var lon = GARSConstants.MIN_LON
        var lat = GARSConstants.MIN_LAT
        
        for gars in gridRange {
            
            let bandNumber = gars.longitude
            let bandLetters = gars.latitude
            
            XCTAssertEqual(number, bandNumber)
            XCTAssertEqual(GARSUtils.bandLetters(letters), bandLetters)
            XCTAssertEqual(GARSConstants.DEFAULT_QUADRANT, gars.quadrant)
            XCTAssertEqual(GARSConstants.DEFAULT_KEYPAD, gars.keypad)
            
            let point = gars.toPoint()
            
            XCTAssertEqual(lon, point.longitude, accuracy: 0)
            XCTAssertEqual(lat, point.latitude, accuracy: 0)
            
            letters += 1
            lat += GridType.THIRTY_MINUTE.precision()
            if letters > GARSConstants.MAX_BAND_LETTERS_NUMBER {
                letters = GARSConstants.MIN_BAND_LETTERS_NUMBER
                lat = GARSConstants.MIN_LAT
                number += 1
                lon += GridType.THIRTY_MINUTE.precision()
            }
            
            count += 1
        }
        
        XCTAssertEqual(GARSConstants.MAX_BAND_NUMBER * GARSConstants.MAX_BAND_LETTERS_NUMBER, count)
    }
    
    /**
     * Test the WGS84 coordinate with expected GARS coordinate
     *
     * @param longitude
     *            longitude in degrees
     * @param latitude
     *            latitude in degrees
     * @param value
     *            GARS value
     */
    func testCoordinate(_ longitude: Double, _ latitude: Double, _ value: String) {
        let point = GridPoint(longitude, latitude)
        testCoordinate(point, value)
        testCoordinate(point.toMeters(), value)
    }

    /**
     * Test the WGS84 coordinate with expected GARS coordinate
     *
     * @param longitude
     *            longitude in degrees
     * @param latitude
     *            latitude in degrees
     * @param value
     *            GARS value
     */
    func testCoordinateMeters(_ longitude: Double, _ latitude: Double, _ value: String) {
        let point = GridPoint.meters(longitude, latitude)
        testCoordinate(point, value)
        testCoordinate(point.toDegrees(), value)
    }

    /**
     * Test the coordinate with expected GARS coordinate
     *
     * @param point
     *            point
     * @param value
     *            GARS value
     */
    func testCoordinate(_ point: GridPoint, _ value: String) {

        let gars = GARS.from(point)
        XCTAssertEqual(value, gars.description)
        XCTAssertEqual(value, gars.coordinate())
        XCTAssertEqual(value, gars.coordinate(GridType.FIVE_MINUTE))
        XCTAssertEqual(value, gars.coordinate(nil))
        
        XCTAssertEqual(String(value.prefix(5)),
                       gars.coordinate(GridType.TWENTY_DEGREE))
        XCTAssertEqual(String(value.prefix(5)),
                       gars.coordinate(GridType.TEN_DEGREE))
        XCTAssertEqual(String(value.prefix(5)),
                       gars.coordinate(GridType.FIVE_DEGREE))
        XCTAssertEqual(String(value.prefix(5)),
                       gars.coordinate(GridType.ONE_DEGREE))
        XCTAssertEqual(String(value.prefix(5)),
                       gars.coordinate(GridType.THIRTY_MINUTE))
        XCTAssertEqual(String(value.prefix(6)),
                       gars.coordinate(GridType.FIFTEEN_MINUTE))

    }
    
}
