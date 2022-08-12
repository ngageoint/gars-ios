//
//  Grids.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation
import grid_ios

/**
 * Grids
 */
public class Grids: BaseGrids {
    
    /**
     * Grids
     */
    private var typeGrids: [GridType: Grid] = [:]
    
    /**
     * Initialize, all grid types enabled per property configurations
     */
    public init() {
        super.init(GARSProperties.instance)
        createGrids()
        createZoomGrids()
    }

    /**
     * Initialize
     *
     * @param types
     *            grid types to enable
     */
    public init(_ types: [GridType]) {
        super.init(GARSProperties.instance)

        createGrids(false)

        for type in types {
            grid(type).enabled = true
        }

        createZoomGrids()
    }
    
    /**
     * Get the default grid line width
     *
     * @return width
     */
    public override func defaultWidth() -> Double {
        return Grid.DEFAULT_WIDTH
    }

    /**
     * Get the grids
     *
     * @return grids
     */
    public override func grids() -> [BaseGrid] {
        return Array(typeGrids.values)
    }

    /**
     * Create a new grid, override to create a specialized grid
     *
     * @param type
     *            grid type
     * @return grid
     */
    public func newGrid(_ type: GridType) -> Grid {
        return Grid(type)
    }
    
    /**
     * Create a new zoom grids
     *
     * @param zoom
     *            zoom level
     * @return zoom grids
     */
    public override func newZoomGrids(_ zoom: Int) -> BaseZoomGrids {
        return ZoomGrids(zoom)
    }
    
    public override func grids(_ zoom: Int) -> ZoomGrids {
        return super.grids(zoom) as! ZoomGrids
    }
    
    /**
     * Create the grids
     */
    private func createGrids() {
        createGrids(nil)
    }
    
    /**
     * Create the grids
     *
     * @param enabled
     *            enable created grids
     */
    private func createGrids(_ enabled: Bool?) {
        
        let propagate = properties.boolValue(PropertyConstants.GRIDS, PropertyConstants.PROPAGATE, false)
        var styles: [GridType: GridStyle]? = nil
        if (propagate != nil && propagate!) {
            styles = [:]
        }
        
        createGrid(GridType.TWENTY_DEGREE, &styles, enabled, GARSLabeler())
        createGrid(GridType.TEN_DEGREE, &styles, enabled, GARSLabeler())
        createGrid(GridType.FIVE_DEGREE, &styles, enabled, GARSLabeler())
        createGrid(GridType.ONE_DEGREE, &styles, enabled, GARSLabeler())
        createGrid(GridType.THIRTY_MINUTE, &styles, enabled, GARSLabeler())
        createGrid(GridType.FIFTEEN_MINUTE, &styles, enabled, GARSLabeler())
        createGrid(GridType.FIVE_MINUTE, &styles, enabled, GARSLabeler())
        
    }
    
    /**
     * Create the grid
     *
     * @param type
     *            grid type
     * @param styles
     *            propagate grid styles
     * @param enabled
     *            enable created grids
     * @param labeler
     *            grid labeler
     */
    private func createGrid(_ type: GridType, _ styles: inout [GridType: GridStyle]?, _ enabled: Bool?, _ labeler: GridLabeler?) {
        
        let grid = newGrid(type)
        
        let gridKey = type.name.lowercased()
        
        loadGrid(grid, gridKey, enabled, labeler)
        
        if (styles != nil) {
            styles![type] = GridStyle(grid.color, grid.width)
        }
        
        loadGridStyles(grid, &styles, gridKey)
        
        typeGrids[type] = grid
    }
    
    /**
     * Load grid styles within a higher precision grid
     *
     * @param grid
     *            grid
     * @param styles
     *            propagate grid styles
     * @param gridKey
     *            grid key
     */
    private func loadGridStyles(_ grid: Grid, _ styles: inout [GridType: GridStyle]?, _ gridKey: String) {
        
        let precision = grid.precision()
        if (precision < GridType.TWENTY_DEGREE.precision()) {
            loadGridStyle(grid, &styles, gridKey, GridType.TWENTY_DEGREE)
        }
        if (precision < GridType.TEN_DEGREE.precision()) {
            loadGridStyle(grid, &styles, gridKey, GridType.TEN_DEGREE)
        }
        if (precision < GridType.FIVE_DEGREE.precision()) {
            loadGridStyle(grid, &styles, gridKey, GridType.FIVE_DEGREE)
        }
        if (precision < GridType.ONE_DEGREE.precision()) {
            loadGridStyle(grid, &styles, gridKey, GridType.ONE_DEGREE)
        }
        if (precision < GridType.THIRTY_MINUTE.precision()) {
            loadGridStyle(grid, &styles, gridKey, GridType.THIRTY_MINUTE)
        }
        if (precision < GridType.FIFTEEN_MINUTE.precision()) {
            loadGridStyle(grid, &styles, gridKey, GridType.FIFTEEN_MINUTE)
        }
        
    }
    
    /**
     * Load a grid style within a higher precision grid
     *
     * @param grid
     *            grid
     * @param styles
     *            propagate grid styles
     * @param gridKey
     *            grid key
     * @param gridType
     *            style grid type
     */
    private func loadGridStyle(_ grid: Grid, _ styles: inout [GridType: GridStyle]?, _ gridKey: String, _ gridType: GridType) {
        
        let gridKey2 = gridType.name.lowercased()

        var color = loadGridStyleColor(gridKey, gridKey2)
        var width = loadGridStyleWidth(gridKey, gridKey2)

        if ((color == nil || width == nil) && styles != nil) {
            let style = styles![gridType]
            if (style != nil) {
                if (color == nil) {
                    let styleColor = style!.color
                    if (styleColor != nil) {
                        color = styleColor!.mutableCopy() as? UIColor
                    }
                }
                if (width == nil) {
                    width = style?.width
                }
            }
        }

        if (color != nil || width != nil) {

            let style = gridStyle(color, width, grid)
            grid.setStyle(gridType, style)

            if (styles != nil) {
                styles![gridType] = style
            }
        }
        
    }
    
    /**
     * Get the grid
     *
     * @param type
     *            grid type
     * @return grid
     */
    public func grid(_ type: GridType) -> Grid {
        return typeGrids[type]!
    }
    
    /**
     * Get the grid precision for the zoom level
     *
     * @param zoom
     *            zoom level
     * @return grid type precision
     */
    
    public func precision(_ zoom: Int) -> GridType? {
        return grids(zoom).precision()
    }

    /**
     * Set the active grid types
     *
     * @param types
     *            grid types
     */
    public func setGrids(_ types: [GridType]) {
        var disable = Set(GridType.allCases)
        for gridType in types {
            enable(gridType)
            disable.remove(gridType)
        }
        disableTypes(Array(disable))
    }

    /**
     * Set the active grids
     *
     * @param grids
     *            grids
     */
    public func setGrids(_ grids: [Grid]) {
        var disable = Set(GridType.allCases)
        for grid in grids {
            enable(grid)
            disable.remove(grid.type)
        }
        disableTypes(Array(disable))
    }
    
    /**
     * Enable grid types
     *
     * @param types
     *            grid types
     */
    public func enableTypes(_ types: [GridType]) {
        for type in types {
            enable(type)
        }
    }
    
    /**
     * Disable grid types
     *
     * @param types
     *            grid types
     */
    public func disableTypes(_ types: [GridType]) {
        for type in types {
            disable(type)
        }
    }
    
    /**
     * Is the grid type enabled
     *
     * @param type
     *            grid type
     * @return true if enabled
     */
    public func isEnabled(_ type: GridType) -> Bool {
        return grid(type).enabled
    }

    /**
     * Enable the grid type
     *
     * @param type
     *            grid type
     */
    public func enable(_ type: GridType) {
        enable(grid(type))
    }

    /**
     * Disable the grid type
     *
     * @param type
     *            grid type
     */
    public func disable(_ type: GridType) {
        disable(grid(type))
    }
    
    /**
     * Set the grid minimum zoom
     *
     * @param type
     *            grid type
     * @param minZoom
     *            minimum zoom
     */
    public func setMinZoom(_ type: GridType, _ minZoom: Int) {
        setMinZoom(grid(type), minZoom)
    }

    /**
     * Set the grid maximum zoom
     *
     * @param type
     *            grid type
     * @param maxZoom
     *            maximum zoom
     */
    public func setMaxZoom(_ type: GridType, _ maxZoom: Int?) {
        setMaxZoom(grid(type), maxZoom)
    }
    
    /**
     * Set the grid zoom range
     *
     * @param type
     *            grid type
     * @param minZoom
     *            minimum zoom
     * @param maxZoom
     *            maximum zoom
     */
    public func setZoomRange(_ type: GridType, _ minZoom: Int, _ maxZoom: Int?) {
        setZoomRange(grid(type), minZoom, maxZoom)
    }
    
    /**
     * Set the grid minimum level override for drawing grid lines
     *
     * @param type
     *            grid type
     * @param minZoom
     *            minimum zoom level or null to remove
     */
    public func setLinesMinZoom(_ type: GridType, _ minZoom: Int?) {
        grid(type).linesMinZoom = minZoom
    }

    /**
     * Set the grid maximum level override for drawing grid lines
     *
     * @param type
     *            grid type
     * @param maxZoom
     *            maximum zoom level or null to remove
     */
    public func setLinesMaxZoom(_ type: GridType, _ maxZoom: Int?) {
        grid(type).linesMaxZoom = maxZoom
    }
    
    // TODO
    
}
