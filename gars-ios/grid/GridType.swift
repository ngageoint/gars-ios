//
//  GridType.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/9/22.
//

import Foundation

/**
 * Grid type enumeration
 */
public enum GridType: Int, CaseIterable {
    
    /**
     * Twenty Degree
     */
    case TWENTY_DEGREE
    
    /**
     * Ten Degree
     */
    case TEN_DEGREE
    
    /**
     * Five Degree
     */
    case FIVE_DEGREE
    
    /**
     * One Degree
     */
    case ONE_DEGREE
    
    /**
     * Thirty Minute
     */
    case THIRTY_MINUTE
    
    /**
     * Fifteen Minute
     */
    case FIFTEEN_MINUTE
    
    /**
     * Five Minute
     */
    case FIVE_MINUTE

    /**
     * Get the precision in degrees
     *
     * @return precision degrees
     */
    public func precision() -> Double {
        let precision: Double
        switch self {
        case .TWENTY_DEGREE:
            precision = 20.0
        case .TEN_DEGREE:
            precision = 10.0
        case .FIVE_DEGREE:
            precision = 5.0
        case .ONE_DEGREE:
            precision = 1.0
        case .THIRTY_MINUTE:
            precision = 0.5
        case .FIFTEEN_MINUTE:
            precision = 0.25
        case .FIVE_MINUTE:
            precision = 0.25 / 3.0
        }
        return precision
    }
    
    /**
     * Get the precision of the value in degrees
     *
     * @param value
     *            value in degrees
     * @return precision grid type
     */
    public static func precision(_ value: Double) -> GridType {
        let precision: GridType
        if (value.truncatingRemainder(dividingBy: TWENTY_DEGREE.precision()) == 0) {
            precision = TWENTY_DEGREE
        } else if (value.truncatingRemainder(dividingBy: TEN_DEGREE.precision()) == 0) {
            precision = TEN_DEGREE
        } else if (value.truncatingRemainder(dividingBy: FIVE_DEGREE.precision()) == 0) {
            precision = FIVE_DEGREE
        } else if (value.truncatingRemainder(dividingBy: ONE_DEGREE.precision()) == 0) {
            precision = ONE_DEGREE
        } else if (value.truncatingRemainder(dividingBy: THIRTY_MINUTE.precision()) == 0) {
            precision = THIRTY_MINUTE
        } else if (value.truncatingRemainder(dividingBy: FIFTEEN_MINUTE.precision()) == 0) {
            precision = FIFTEEN_MINUTE
        } else {
            precision = FIVE_MINUTE
        }
        return precision
    }
    
    /**
     * Get the less precise (larger precision value) grid types
     *
     * @param type
     *            grid type
     * @return grid types less precise
     */
    public static func lessPrecise(_ type: GridType) -> [GridType] {
        let cases = self.allCases
        let index = cases.firstIndex(of: type)
        return Array(cases.prefix(upTo: index!))
    }
    
    /**
     * Get the more precise (smaller precision value) grid types
     *
     * @param type
     *            grid type
     * @return grid types more precise
     */
    public static func morePrecise(_ type: GridType) -> [GridType] {
        let cases = self.allCases
        let index = cases.firstIndex(of: type)
        return Array(cases.suffix(from: index! + 1))
    }
    
}
