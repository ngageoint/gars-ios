//
//  GARSUtils.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation
import grid_ios

/**
 * Global Area Reference System utilities
 */
public class GARSUtils {

    /**
     * Get the longitude from the longitude band
     *
     * @param band
     *            longitudinal band number
     * @return longitude
     */
    public static func longitude(_ band: Int) -> Double {
        return GARSConstants.MIN_LON
            + (Double(band - 1) * GridType.THIRTY_MINUTE.precision())
    }
    
    /**
     * Get the latitude from the latitude band letters
     *
     * @param band
     *            latitudinal band letters
     * @return latitude
     */
    public static func latitude(_ band: String) -> Double {
        return latitude(bandValue(band))
    }

    /**
     * Get the latitude from the latitude band letters number equivalent
     *
     * @param band
     *            latitudinal band number
     * @return latitude
     */
    public static func latitude(_ band: Int) -> Double {
        return GARSConstants.MIN_LAT
            + (Double(band - 1) * GridType.THIRTY_MINUTE.precision())
    }
    
    /**
     * Get the longitude band from the longitude
     *
     * @param longitude
     *            longitude
     * @return longitude band
     */
    public static func longitudeBand(_ longitude: Double) -> Int {
        return Int(longitudeDecimalBand(longitude))
    }

    /**
     * Get the longitude decimal band from the longitude
     *
     * @param longitude
     *            longitude
     * @return longitude decimal band
     */
    public static func longitudeDecimalBand(_ longitude: Double) -> Double {
        return ((longitude - GARSConstants.MIN_LON)
                / GridType.THIRTY_MINUTE.precision()) + 1.0
    }

    /**
     * Get the latitude band letters from the latitude
     *
     * @param latitude
     *            latitude
     * @return latitude band letters
     */
    public static func latitudeBand(_ latitude: Double) -> String {
        return bandLetters(latitudeBandValue(latitude))
    }

    /**
     * Get the latitude band value from the latitude
     *
     * @param latitude
     *            latitude
     * @return latitude band value
     */
    public static func latitudeBandValue(_ latitude: Double) -> Int {
        return Int(latitudeDecimalBandValue(latitude))
    }

    /**
     * Get the latitude decimal band value from the latitude
     *
     * @param latitude
     *            latitude
     * @return latitude decimal band value
     */
    public static func latitudeDecimalBandValue(_ latitude: Double) -> Double {
        return ((latitude - GARSConstants.MIN_LAT)
                / GridType.THIRTY_MINUTE.precision()) + 1.0
    }
    
    /**
     * Get the latitude band number equivalent to the longitude band (where AA
     * is 1 and QZ is 360)
     *
     * @param latitudeBand
     *            two character latitude band
     * @return number band value
     */
    public static func bandValue(_ latitudeBand: String) -> Int {
        let latitude = latitudeBand.uppercased()
        let latitude1 = bandValue(latitude.first!)
        let latitude2 = bandValue(latitude.last!)
        return 24 * (latitude1 - 1) + latitude2
    }
    
    /**
     * Get the latitude character band number equivalent (where A is 1 and Z is
     * 24)
     *
     * @param latitudeBand
     *            single character from latitude band
     * @return number band value
     */
    public static func bandValue(_ latitudeBand: Character) -> Int {
        var value: Int = Int(latitudeBand.asciiValue!) - Int(GARSConstants.MIN_BAND_LETTER.asciiValue!) + 1
        if (latitudeBand > GridConstants.BAND_LETTER_OMIT_I) {
            value -= 1
            if (latitudeBand > GridConstants.BAND_LETTER_OMIT_O) {
                value -= 1
            }
        }
        return value
    }
    
    /**
     * Get the latitude band from the band number (where 1 is AA and 360 is QZ)
     *
     * @param bandValue
     *            number band value
     * @return two character latitude band
     */
    public static func bandLetters(_ bandValue: Int) -> String {
        let value = bandValue - 1
        let latitude1 = value / 24
        let latitude2 = value % 24
        return String(bandLetter(latitude1 + 1))
            + String(bandLetter(latitude2 + 1))
    }

    /**
     * Get the latitude character equivalent from the band number (where 1 is A
     * and 24 is Z)
     *
     * @param bandValue
     *            number band value
     * @return single character of latitude band
     */
    public static func bandLetter(_ bandValue: Int) -> Character {
        var letter = Int(GARSConstants.MIN_BAND_LETTER.asciiValue!)
        letter += bandValue - 1
        if (letter >= GridConstants.BAND_LETTER_OMIT_I.asciiValue!) {
            letter += 1
            if (letter >= GridConstants.BAND_LETTER_OMIT_O.asciiValue!) {
                letter += 1
            }
        }
        return Character(UnicodeScalar(letter)!)
    }
    
    /**
     * Get the quadrant southwest origin 0 indexed column
     *
     * @param quadrant
     *            quadrant number
     * @return 0 for quadrants 1|3, 1 for quadrants 2|4
     */
    public static func quadrantColumn(_ quadrant: Int) -> Int {
        return quadrant % 2 == 0 ? 1 : 0
    }

    /**
     * Get the quadrant southwest origin 0 indexed row
     *
     * @param quadrant
     *            quadrant number
     * @return 0 for quadrants 3|4, 1 for quadrants 1|2
     */
    public static func quadrantRow(_ quadrant: Int) -> Int {
        return quadrant >= 3 ? 0 : 1
    }

    /**
     * Get the keypad southwest origin 0 indexed column
     *
     * @param keypad
     *            keypad number
     * @return 0 for keypads 1|4|7, 1 for keypads 2|5|8, 2 for keypads 3|6|9
     */
    public static func keypadColumn(_ keypad: Int) -> Int {
        var column = 0
        if (keypad % 3 == 0) {
            column = 2
        } else if ((keypad + 1) % 3 == 0) {
            column = 1
        }
        return column
    }

    /**
     * Get the keypad southwest origin 0 indexed row
     *
     * @param keypad
     *            keypad number
     * @return 0 for keypads 7|8|9, 1 for keypads 4|5|6, 2 for keypads 1|2|3
     */
    public static func keypadRow(_ keypad: Int) -> Int {
        var row = 0
        if (keypad <= 3) {
            row = 2
        } else if (keypad <= 6) {
            row = 1
        }
        return row
    }

    /**
     * Get the quadrant from the southwest origin 0 indexed column and row
     *
     * @param column
     *            0 indexed column
     * @param row
     *            0 indexed row
     * @return quadrant
     */
    public static func quadrant(_ column: Int, _ row: Int) -> Int {
        return (1 - row) * 2 + column + 1
    }

    /**
     * Get the keypad from the southwest origin 0 indexed column and row
     *
     * @param column
     *            0 indexed column
     * @param row
     *            0 indexed row
     * @return keypad
     */
    public static func keypad(_ column: Int, _ row: Int) -> Int {
        return (2 - row) * 3 + column + 1
    }
    
    /**
     * Get a grid range from the bounds
     *
     * @param bounds
     *            bounds
     * @return grid range
     */
    public static func gridRange(_ bounds: Bounds) -> GridRange {
        let boundsDegrees = bounds.toDegrees()
        let bandNumberRange = bandNumberRange(boundsDegrees)
        let bandLettersRange = bandLettersRange(boundsDegrees)
        return GridRange(bandNumberRange, bandLettersRange)
    }

    /**
     * Get a band number range between the western and eastern bounds
     *
     * @param bounds
     *            bounds
     * @return band number range
     */
    public static func bandNumberRange(_ bounds: Bounds) -> BandNumberRange {
        let boundsDegrees = bounds.toDegrees()
        return bandNumberRange(boundsDegrees.minLongitude,
                               boundsDegrees.maxLongitude)
    }

    /**
     * Get a band number range between the western and eastern longitudes
     *
     * @param west
     *            western longitude in degrees
     * @param east
     *            eastern longitude in degrees
     * @return band number range
     */
    public static func bandNumberRange(_ west: Double, _ east: Double) -> BandNumberRange {
        let westBand = longitudeBand(west)
        let eastBand = longitudeBand(east)
        return BandNumberRange(westBand, eastBand)
    }

    /**
     * Get a band letters range between the southern and northern bounds
     *
     * @param bounds
     *            bounds
     * @return band letters range
     */
    public static func bandLettersRange(_ bounds: Bounds) -> BandLettersRange {
        let boundsDegrees = bounds.toDegrees()
        return bandLettersRange(boundsDegrees.minLatitude,
                                   boundsDegrees.maxLatitude)
    }

    /**
     * Get a band letters range between the southern and northern latitudes in
     * degrees
     *
     * @param south
     *            southern latitude in degrees
     * @param north
     *            northern latitude in degrees
     * @return band letters range
     */
    public static func bandLettersRange(_ south: Double, _ north: Double) -> BandLettersRange {
        let southBand = latitudeBand(south)
        let northBand = latitudeBand(north)
        return BandLettersRange(southBand, northBand)
    }

    /**
     * Create a degree grid label
     *
     * @param longitude
     *            longitude
     * @param latitude
     *            latitude
     * @return degree label
     */
    public static func degreeLabel(_ longitude: Double, _ latitude: Double) -> String {
        return String(abs(Int(longitude)))
            + (longitude < 0 ? GridConstants.WEST_CHAR : GridConstants.EAST_CHAR)
            + String(abs(Int(latitude)))
            + (latitude < 0 ? GridConstants.SOUTH_CHAR : GridConstants.NORTH_CHAR)
    }

    /**
     * Get the next precision value from the precision value and precision
     *
     * @param value
     *            precision value
     * @param precision
     *            grid precision
     * @return next precision value
     */
    public static func nextPrecision(_ value: Double, _ precision: Double) -> Double {
        var nextValue = value
        if (precision < GridType.FIFTEEN_MINUTE.precision()) {
            nextValue = GridUtils.precisionAfter(value + 0.5 * precision,
                    precision)
        } else {
            nextValue += precision
        }
        return nextValue
    }
    
}
