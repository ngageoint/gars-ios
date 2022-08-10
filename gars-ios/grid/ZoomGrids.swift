//
//  ZoomGrids.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation
import grid_ios

/**
 * Zoom Level Matching Grids
 */
public class ZoomGrids: BaseZoomGrids {
    
    /**
     * Initialize
     *
     * @param zoom
     *            zoom level
     */
    public override init(_ zoom: Int) {
        super.init(zoom)
    }
    
    /**
     * Get the grid type precision
     *
     * @return grid type precision
     */
    public func precision() -> GridType? {
        var type: GridType? = nil
        if (hasGrids()) {
            type = (grids.first as! Grid).type
        }
        return type
    }
    
}
