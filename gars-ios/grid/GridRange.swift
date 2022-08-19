//
//  GridRange.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation
import grid_ios

/**
 * Grid Range
 */
public class GridRange: Sequence {
    
    /**
     * Band Number Range
     */
    public var bandNumberRange: BandNumberRange
    
    /**
     * Band Letters Range
     */
    public var bandLettersRange: BandLettersRange
    
    /**
     * Initialize, full range
     */
    public init() {
        self.bandNumberRange = BandNumberRange()
        self.bandLettersRange = BandLettersRange()
    }
    
    /**
     * Initialize
     *
     * @param bandNumberRange
     *            band number range
     * @param bandLettersRange
     *            band letters range
     */
    public init(_ bandNumberRange: BandNumberRange, _ bandLettersRange: BandLettersRange) {
        self.bandNumberRange = bandNumberRange
        self.bandLettersRange = bandLettersRange
    }
    
    /**
     * Get the grid range bounds
     *
     * @return bounds
     */
    public func bounds() -> Bounds {

        let west = bandNumberRange.westLongitude()
        let south = bandLettersRange.southLatitude()
        let east = bandNumberRange.eastLongitude()
        let north = bandLettersRange.northLatitude()

        return Bounds.degrees(west, south, east, north)
    }
    
    public func makeIterator() -> GridRangeIterator {
        return GridRangeIterator(self)
    }
    
}

public struct GridRangeIterator: IteratorProtocol {
    
    var bandLettersRange: BandLettersRange
    var bandNumbers: BandNumberRangeIterator
    var bandLetters: BandLettersRangeIterator
    var bandNumber: Int? = nil

    init(_ range: GridRange) {
        bandLettersRange = range.bandLettersRange
        bandNumbers = range.bandNumberRange.makeIterator()
        bandLetters = bandLettersRange.makeIterator()
        bandNumber = bandNumbers.next()
    }

    public mutating func next() -> GARS? {
        var letters = bandLetters.next()
        if letters == nil {
            bandNumber = bandNumbers.next()
            bandLetters = bandLettersRange.makeIterator()
            letters = bandLetters.next()
        }
        var gars: GARS? = nil
        if bandNumber != nil && letters != nil {
            gars = GARS(bandNumber!, letters!)
        }
        return gars
    }
    
}
