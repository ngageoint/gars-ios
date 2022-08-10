//
//  BandNumberRange.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/9/22.
//

import Foundation

/**
 * Longitude Band Number Range
 */
public class BandNumberRange: Sequence {
    
    /**
     * Western band number
     */
    public var west: Int
    
    /**
     * Eastern band number
     */
    public var east: Int
    
    /**
     * Initialize, full range
     */
    public convenience init() {
        self.init(GARSConstants.MIN_BAND_NUMBER, GARSConstants.MAX_BAND_NUMBER)
    }
    
    /**
     * Initialize
     *
     * @param west
     *            western band number
     * @param east
     *            eastern band number
     */
    public init(_ west: Int, _ east: Int) {
        self.west = west
        self.east = east
    }
    
    /**
     * Get the western longitude
     *
     * @return longitude
     */
    public func westLongitude() -> Double {
        return GARSUtils.longitude(west)
    }
    
    /**
     * Get the eastern longitude
     *
     * @return longitude
     */
    public func eastLongitude() -> Double {
        return GARSUtils.longitude(east)
    }
    
    public func makeIterator() -> BandNumberRangeIterator {
        return BandNumberRangeIterator(self)
    }
    
}

public struct BandNumberRangeIterator: IteratorProtocol {
    
    var number: Int
    var east: Int

    init(_ range: BandNumberRange) {
        self.number = range.west
        self.east = range.east
    }

    public mutating func next() -> Int? {
        var value: Int? = nil
        if (number <= east) {
            value = number
            number += 1
        }
        return value
    }
    
}
