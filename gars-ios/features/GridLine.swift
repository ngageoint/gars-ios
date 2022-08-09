//
//  GridLine.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/9/22.
//

import Foundation
import grid_ios

/**
 * Line between two points
 */
public class GridLine: Line {
    
    /**
     * Grid type the line represents if any
     */
    public var gridType: GridType?
    
    /**
     * Initialize
     *
     * @param point1
     *            first point
     * @param point2
     *            second point
     */
    public override init(point1: GridPoint, point2: GridPoint) {
        super.init(point1: point1, point2: point2)
    }
    
    /**
     * Initialize
     *
     * @param point1
     *            first point
     * @param point2
     *            second point
     * @param gridType
     *            line grid type
     */
    public convenience init(point1: GridPoint, point2: GridPoint, gridType: GridType?) {
        self.init(point1: point1, point2: point2)
        self.gridType = gridType
    }
    
    /**
     * Initialize
     *
     * @param line
     *            line to copy
     */
    public override init(line: Line) {
        super.init(line: line)
    }
    
    /**
     * Initialize
     *
     * @param line
     *            line to copy
     * @param gridType
     *            line grid type
     */
    public convenience init(line: Line, gridType: GridType?) {
        self.init(line: line)
        self.gridType = gridType
    }
    
    /**
     * Initialize
     *
     * @param gridLine
     *            line to copy
     */
    public convenience init(gridLine: GridLine) {
        self.init(line: gridLine, gridType: gridLine.gridType)
    }
    
    /**
     * Check if the line has a grid type
     *
     * @return true if has grid type
     */
    public func hasGridType() -> Bool {
        return gridType != nil
    }
    
    public override func mutableCopy(with zone: NSZone? = nil) -> Any {
        return GridLine(gridLine: self)
    }
    
    public override func encode(with coder: NSCoder) {
        let gridValue = gridType != nil ? gridType?.rawValue : -1
        coder.encode(gridValue, forKey: "gridType")
        super.encode(with: coder)
    }
    
    public required init?(coder: NSCoder) {
        let gridValue = coder.decodeInteger(forKey: "gridType")
        if (gridValue >= 0) {
            gridType = GridType.init(rawValue: gridValue)
        }
        super.init(coder: coder)
    }
    
    public func isEqual(gridLine: GridLine?) -> Bool {
        if(self == gridLine) {
            return true
        }
        if(gridLine == nil) {
            return false
        }
        if(!super.isEqual(gridLine)) {
            return false
        }
        return true
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        
        if(!(object is GridLine)) {
            return false
        }
        
        return isEqual(gridLine: object as? GridLine)
    }

    public override var hash: Int {
        let prime = 31
        var result = super.hash
        result = prime * result + ((gridType == nil) ? -1 : gridType!.rawValue)
        return result
    }
    
}
