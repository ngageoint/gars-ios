//
//  GARS.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation
import grid_ios

/**
 * Global Area Reference System Coordinate
 */
public class GARS: Hashable {
    
    /**
     * Longitudinal band number
     */
    public let longitude: Int
    
    /**
     * Latitudinal band letters
     */
    public let latitude: String
    
    /**
     * 15 minute quadrant
     */
    public let quadrant: Int
    
    /**
     * 5 minute keypad
     */
    public let keypad: Int
    
    /**
     * Initialize, default southwest corner quadrant
     * GARSConstants.DEFAULT_QUADRANT and keypad
     * GARSConstants.DEFAULT_KEYPAD
     *
     * @param longitude
     *            longitudinal band number
     * @param latitude
     *            latitudinal band letters
     */
    public convenience init(_ longitude: Int, _ latitude: String) {
        self.init(longitude, latitude, GARSConstants.DEFAULT_QUADRANT, GARSConstants.DEFAULT_KEYPAD)
    }

    /**
     * Initialize
     *
     * @param longitude
     *            longitudinal band number
     * @param latitude
     *            latitudinal band letters
     * @param quadrant
     *            15 minute quadrant
     * @param keypad
     *            5 minute keypad
     */
    public init(_ longitude: Int, _ latitude: String, _ quadrant: Int, _ keypad: Int) {
        self.longitude = longitude
        self.latitude = latitude
        self.quadrant = quadrant
        self.keypad = keypad
    }
    
    /**
     * Get the GARS coordinate with five minute precision
     *
     * @return GARS coordinate
     */
    public func coordinate() -> String {
        return coordinate(GridType.FIVE_MINUTE)
    }

    /**
     * Get the GARS coordinate with specified grid precision
     *
     * @param type
     *            grid type precision
     * @return GARS coordinate
     */
    public func coordinate(_ type: GridType?) -> String {

        let gridType = type != nil ? type : GridType.FIVE_MINUTE
        
        var gars = String(format: "%03d", longitude) + latitude

        if (gridType == GridType.FIFTEEN_MINUTE || gridType == GridType.FIVE_MINUTE) {

            gars = gars.appending(String(quadrant))

            if (gridType == GridType.FIVE_MINUTE) {

                gars = gars.appending(String(keypad))

            }

        }

        return gars
    }
    
    /**
     * Convert to a point
     *
     * @return point
     */
    public func toPoint() -> GridPoint {

        var lon = GARSUtils.longitude(longitude)
        var lat = GARSUtils.latitude(latitude)

        lon += Double(GARSUtils.quadrantColumn(quadrant))
                * GridType.FIFTEEN_MINUTE.precision()
        lat += Double(GARSUtils.quadrantRow(quadrant))
                * GridType.FIFTEEN_MINUTE.precision()

        lon += Double(GARSUtils.keypadColumn(keypad))
                * GridType.FIVE_MINUTE.precision()
        lat += Double(GARSUtils.keypadRow(keypad))
                * GridType.FIVE_MINUTE.precision()

        return GridPoint(lon, lat)
    }
    
    public var description: String {
        return coordinate()
    }

    public static func == (lhs: GARS, rhs: GARS) -> Bool {
        return lhs.longitude == rhs.longitude
            && lhs.latitude == rhs.latitude
            && lhs.quadrant == rhs.quadrant
            && lhs.keypad == rhs.keypad
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(longitude)
        hasher.combine(latitude)
        hasher.combine(quadrant)
        hasher.combine(keypad)
    }
    
    /**
     * Return whether the given string is valid GARS string
     *
     * @param gars
     *            potential GARS string
     * @return true if GARS string is valid, false otherwise
     */
    public static func isGARS(_ gars: String) -> Bool {
        let garsValue = removeSpaces(gars)
        return false // TODO
    }
    
    /**
     * Removed spaces from the value
     *
     * @param value
     *            value string
     * @return value without spaces
     */
    private static func removeSpaces(_ value: String) -> String {
        return value.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
    }
    
    /**
     * Convert the coordinate to GARS
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @return GARS
     */
    public static func from(_ longitude: Double, _ latitude: Double) -> GARS {
    
        let lon = GARSUtils.longitudeDecimalBand(longitude)
        let lat = GARSUtils.latitudeDecimalBandValue(latitude)

        let lonInt = Int(lon)
        let latInt = Int(lat)

        let latBand = GARSUtils.bandLetters(latInt)

        var lonDecimal = lon - Double(lonInt)
        var latDecimal = lat - Double(latInt)

        let quadrantColumn = lonDecimal * 2.0
        let quadrantRow = latDecimal * 2.0

        let quadrantColumnInt = Int(quadrantColumn)
        let quadrantRowInt = Int(quadrantRow)

        let quadrant = GARSUtils.quadrant(quadrantColumnInt, quadrantRowInt)

        lonDecimal = quadrantColumn - Double(quadrantColumnInt)
        latDecimal = quadrantRow - Double(quadrantRowInt)

        let keypadColumn = Int(lonDecimal * 3.0)
        let keypadRow = Int(latDecimal * 3.0)

        let keypad = GARSUtils.keypad(keypadColumn, keypadRow)

        return GARS(lonInt, latBand, quadrant, keypad)
    }
    
    /**
     * Parse a GARS string
     *
     * @param gars
     *            GARS string
     * @return GARS
     */
    public static func parse(_ gars: String) -> GARS {
        return GARS(0, "AA", 0, 0) // TODO
    }
    
    /**
     * Parse the GARS string for the precision
     *
     * @param gars
     *            GARS string
     * @return grid type precision
     */
    public static func precision(_ gars: String) -> GridType {
        return GridType.THIRTY_MINUTE // TODO
    }
    
}
