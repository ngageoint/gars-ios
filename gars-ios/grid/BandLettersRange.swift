//
//  BandLettersRange.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation

/**
 * Latitude Band Letters Range
 */
public class BandLettersRange: Sequence {
    
    /**
     * Southern band letters
     */
    public var south: String
    
    /**
     * Northern band letters
     */
    public var north: String
    
    /**
     * Initialize, full range
     */
    public convenience init() {
        self.init(GARSConstants.MIN_BAND_LETTERS, GARSConstants.MAX_BAND_LETTERS)
    }
    
    /**
     * Initialize
     *
     * @param south
     *            southern band letters
     * @param north
     *            northern band letters
     */
    public init(_ south: String, _ north: String) {
        self.south = south
        self.north = north
    }
    
    /**
     * Get the southern band letters equivalent number value
     *
     * @return southern band letters value
     */
    public func southValue() -> Int {
        return GARSUtils.bandValue(south)
    }

    /**
     * Get the norther band letters equivalent number value
     *
     * @return norther band letters value
     */
    public func northValue() -> Int {
        return GARSUtils.bandValue(north)
    }
    
    /**
     * Get the southern latitude
     *
     * @return latitude
     */
    public func southLatitude() -> Double {
        return GARSUtils.latitude(south)
    }
    
    /**
     * Get the northern latitude
     *
     * @return latitude
     */
    public func northLatitude() -> Double {
        return GARSUtils.latitude(north)
    }
    
    public func makeIterator() -> BandLettersRangeIterator {
        return BandLettersRangeIterator(self)
    }
    
}

public struct BandLettersRangeIterator: IteratorProtocol {
    
    var value: Int
    var maxValue: Int

    init(_ range: BandLettersRange) {
        self.value = range.southValue()
        self.maxValue = range.northValue()
    }

    public mutating func next() -> String? {
        var band: String? = nil
        if (value <= maxValue) {
            band = GARSUtils.bandLetters(value)
            value += 1
        }
        return band
    }
    
}
