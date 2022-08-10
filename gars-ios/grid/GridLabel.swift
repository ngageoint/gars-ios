//
//  GridLabel.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation
import grid_ios

/**
 * GARS Grid Label
 */
public class GridLabel: Label {
    
    /**
     * Grid type
     */
    public var gridType: GridType
    
    /**
     * GARS coordinate
     */
    public var coordinate: GARS
    
    /**
     * Initialize
     *
     * @param name
     *            name
     * @param center
     *            center point
     * @param bounds
     *            bounds
     * @param gridType
     *            grid type
     * @param coordinate
     *            GARS coordinate
     */
    public init(_ name: String, _ center: GridPoint, _ bounds: Bounds, _ gridType: GridType, _ coordinate: GARS) {
        self.gridType = gridType
        self.coordinate = coordinate
        super.init(name, center, bounds)
    }
    
}
