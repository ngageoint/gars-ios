//
//  GARS.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation

/**
 * Global Area Reference System Coordinate
 */
public class GARS {
    
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
    
    // TODO
    
}
