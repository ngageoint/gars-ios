//
//  GARS.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation
import grid_ios
import sf_ios
import MapKit

/**
 * Global Area Reference System Coordinate
 */
public class GARS: Hashable {
    
    /**
     * GARS string pattern
     */
    private static let garsPattern = "^(\\d{3})([A-HJ-NP-Z]{2})(?:([1-4])([1-9])?)?$"
    
    /**
     * GARS regular expression
     */
    private static let garsExpression = try! NSRegularExpression(pattern: garsPattern, options: .caseInsensitive)
    
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

        if gridType == GridType.FIFTEEN_MINUTE || gridType == GridType.FIVE_MINUTE {

            gars = gars.appending(String(quadrant))

            if gridType == GridType.FIVE_MINUTE {

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
    
    /**
     * Convert to a location coordinate
     *
     * @return coordinate
     */
    public func toCoordinate() -> CLLocationCoordinate2D {
        return toPoint().toCoordinate()
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
        let matches = garsExpression.matches(in: garsValue, range: NSMakeRange(0, garsValue.count))
        var isGars = matches.count > 0
        if isGars {
            let match = matches[0]
            let garsString = garsValue as NSString
            let longitude = Int(garsString.substring(with: match.range(at: 1)))!
            isGars = longitude >= GARSConstants.MIN_BAND_NUMBER
                && longitude <= GARSConstants.MAX_BAND_NUMBER
            if isGars {
                let latitude = garsString.substring(with: match.range(at: 2)).uppercased()
                let latitudeValue = GARSUtils.bandValue(latitude)
                isGars = latitudeValue >= GARSConstants.MIN_BAND_LETTERS_NUMBER
                    && latitudeValue <= GARSConstants.MAX_BAND_LETTERS_NUMBER
            }
        }
        return isGars
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
     * Encodes a point as a GARS
     *
     * @param point
     *            point
     * @return GARS
     */
    public static func from(_ point: GridPoint) -> GARS {
        
        let pointDegrees = (point.mutableCopy() as! GridPoint).toDegrees()
        
        // Bound the latitude if needed
        if pointDegrees.latitude < GARSConstants.MIN_LAT {
            pointDegrees.latitude = GARSConstants.MIN_LAT
        } else if pointDegrees.latitude > GARSConstants.MAX_LAT {
            pointDegrees.latitude = GARSConstants.MAX_LAT
        }
        
        // Normalize the longitude if needed
        SFGeometryUtils.normalizeWGS84Geometry(pointDegrees)
        
        let lon = GARSUtils.longitudeDecimalBand(pointDegrees.longitude)
        let lat = GARSUtils.latitudeDecimalBandValue(pointDegrees.latitude)

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
     * Encodes a coordinate as a GARS
     *
     * @param coordinate
     *            coordinate
     * @return GARS
     */
    public static func from(_ coordinate: CLLocationCoordinate2D) -> GARS {
        return from(coordinate.longitude, coordinate.latitude)
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
        return from(GridPoint(longitude, latitude))
    }
    
    /**
     * Convert the coordinate to GARS
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @param unit
     *            unit
     * @return GARS
     */
    public static func from(_ longitude: Double, _ latitude: Double, _ unit: grid_ios.Unit) -> GARS {
        return from(GridPoint(longitude, latitude, unit))
    }
    
    /**
     * Parse a GARS string
     *
     * @param gars
     *            GARS string
     * @return GARS
     */
    public static func parse(_ gars: String) -> GARS {
        let garsValue = removeSpaces(gars)
        let matches = garsExpression.matches(in: garsValue, range: NSMakeRange(0, garsValue.count))
        if matches.count <= 0 {
            preconditionFailure("Invalid GARS: \(gars)")
        }
        
        let match = matches[0]
        let garsString = garsValue as NSString
        
        let longitude = Int(garsString.substring(with: match.range(at: 1)))!
        if longitude < GARSConstants.MIN_BAND_NUMBER
            || longitude > GARSConstants.MAX_BAND_NUMBER {
            preconditionFailure("Invalid GARS longitude: \(longitude), GARS: \(gars)")
        }
        
        let latitude = garsString.substring(with: match.range(at: 2)).uppercased()
        let latitudeValue = GARSUtils.bandValue(latitude)
        if latitudeValue < GARSConstants.MIN_BAND_LETTERS_NUMBER
            || latitudeValue > GARSConstants.MAX_BAND_LETTERS_NUMBER {
            preconditionFailure("Invalid GARS latitude: \(latitude), GARS: \(gars)")
        }
        
        var quadrant = GARSConstants.DEFAULT_QUADRANT
        var keypad = GARSConstants.DEFAULT_KEYPAD
        
        let quadrantMatch = match.range(at: 3)
        if quadrantMatch.length > 0 {
            
            let quadrantValue = garsString.substring(with: quadrantMatch)
            quadrant = Int(quadrantValue)!
            
            let keypadMatch = match.range(at: 4)
            if keypadMatch.length > 0 {
             
                let keypadValue = garsString.substring(with: keypadMatch)
                keypad = Int(keypadValue)!
                
            }
            
        }

        return GARS(longitude, latitude, quadrant, keypad)
    }
    
    /**
     * Parse a GARS string into a location coordinate
     *
     * @param gars
     *            GARS string
     * @return coordinate
     */
    public static func parseToCoordinate(_ gars: String) -> CLLocationCoordinate2D {
        var coordinate = kCLLocationCoordinate2DInvalid
        if isGARS(gars) {
            coordinate = parse(gars).toCoordinate()
        }
        return coordinate
    }
    
    /**
     * Encodes a point as a GARS coordinate with five minute precision
     *
     * @param point
     *            point
     * @return GARS coordinate
     */
    public static func coordinate(_ point: GridPoint) -> String {
        return from(point).coordinate()
    }
    
    /**
     * Encodes a point as a GARS coordinate with specified grid precision
     *
     * @param point
     *            point
     * @param type
     *            grid type precision
     * @return GARS coordinate
     */
    public static func coordinate(_ point: GridPoint, _ type: GridType?) -> String {
        return from(point).coordinate(type)
    }
    
    /**
     * Encodes a coordinate as a GARS coordinate with five minute precision
     *
     * @param coordinate
     *            coordinate
     * @return GARS coordinate
     */
    public static func coordinate(_ coordinate: CLLocationCoordinate2D) -> String {
        return from(coordinate).coordinate()
    }
    
    /**
     * Encodes a coordinate as a GARS coordinate with specified grid precision
     *
     * @param coordinate
     *            coordinate
     * @param type
     *            grid type precision
     * @return GARS coordinate
     */
    public static func coordinate(_ coordinate: CLLocationCoordinate2D, _ type: GridType?) -> String {
        return from(coordinate).coordinate(type)
    }
    
    /**
     * Encodes a coordinate in degrees as a GARS coordinate with five minute precision
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @return GARS coordinate
     */
    public static func coordinate(_ longitude: Double, _ latitude: Double) -> String {
        return from(longitude, latitude).coordinate()
    }
    
    /**
     * Encodes a coordinate in degrees as a GARS coordinate with specified grid precision
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @param type
     *            grid type precision
     * @return GARS coordinate
     */
    public static func coordinate(_ longitude: Double, _ latitude: Double, _ type: GridType?) -> String {
        return from(longitude, latitude).coordinate(type)
    }
    
    /**
     * Encodes a coordinate in the unit as a GARS coordinate with five minute precision
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @param unit
     *            unit
     * @return GARS coordinate
     */
    public static func coordinate(_ longitude: Double, _ latitude: Double, _ unit: grid_ios.Unit) -> String {
        return from(longitude, latitude, unit).coordinate()
    }
    
    /**
     * Encodes a coordinate in the unit as a GARS coordinate with specified grid precision
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @param unit
     *            unit
     * @param type
     *            grid type precision
     * @return GARS coordinate
     */
    public static func coordinate(_ longitude: Double, _ latitude: Double, _ unit: grid_ios.Unit, _ type: GridType?) -> String {
        return from(longitude, latitude, unit).coordinate(type)
    }
    
    /**
     * Parse the GARS string for the precision
     *
     * @param gars
     *            GARS string
     * @return grid type precision
     */
    public static func precision(_ gars: String) -> GridType {
        let garsValue = removeSpaces(gars)
        let matches = garsExpression.matches(in: garsValue, range: NSMakeRange(0, garsValue.count))
        if matches.count <= 0 {
            preconditionFailure("Invalid GARS: \(gars)")
        }
        
        let match = matches[0]
        
        var precision: GridType
        
        if match.range(at: 4).length > 0 {
            precision = GridType.FIVE_MINUTE
        } else if match.range(at: 3).length > 0 {
            precision = GridType.FIFTEEN_MINUTE
        } else {
            precision = GridType.THIRTY_MINUTE
        }
        
        return precision
    }
    
}
