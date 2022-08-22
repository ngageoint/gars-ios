//
//  GARSConstants.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/9/22.
//

import Foundation
import grid_ios

/**
 * Global Area Reference System Constants
 */
public struct GARSConstants {
    
    /**
     * Minimum longitude
     */
    public static let MIN_LON = GridConstants.MIN_LON
    
    /**
     * Maximum longitude
     */
    public static let MAX_LON = GridConstants.MAX_LON

    /**
     * Minimum latitude
     */
    public static let MIN_LAT = GridConstants.MIN_LAT

    /**
     * Maximum latitude
     */
    public static let MAX_LAT = GridConstants.MAX_LAT
    
    /**
     * Minimum grid longitude band number
     */
    public static let MIN_BAND_NUMBER = 1
    
    /**
     * Maximum grid longitude band number
     */
    public static let MAX_BAND_NUMBER = 720

    /**
     * Minimum grid latitude band letters
     */
    public static let MIN_BAND_LETTERS = "AA"

    /**
     * Maximum grid latitude band letters
     */
    public static let MAX_BAND_LETTERS = "QZ"

    /**
     * Minimum grid latitude single band letter
     */
    public static let MIN_BAND_LETTER: Character = "A"

    /**
     * Maximum grid latitude single band letter
     */
    public static let MAX_BAND_LETTER: Character = "Z"
    
    /**
     * Minimum grid latitude band letters number equivalent
     */
    public static let MIN_BAND_LETTERS_NUMBER = 1
    
    /**
     * Maximum grid latitude band letters number equivalent
     */
    public static let MAX_BAND_LETTERS_NUMBER = 360

    /**
     * Default quadrant (southwest corner)
     */
    public static let DEFAULT_QUADRANT = 3

    /**
     * Default keypad (southwest corner)
     */
    public static let DEFAULT_KEYPAD = 7
    
    /**
     * Grid zoom display offset from XYZ tile zoom levels
     */
    public static let ZOOM_OFFSET = -1
    
}
