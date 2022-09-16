//
//  GARSTileOverlay.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/15/22.
//

import MapKit
import grid_ios

/**
 * GARS Tile Overlay
 */
public class GARSTileOverlay: MKTileOverlay {
    
    /**
     * Tile width
     */
    public var tileWidth: Int
    
    /**
     * Tile height
     */
    public var tileHeight: Int
    
    /**
     * Grids
     */
    public var grids: Grids
    
    /**
     * Initialize
     *
     * @param context app context
     */
    public init() {
        let tileLength = TileUtils.tileLength()
        self.tileWidth = tileLength
        self.tileHeight = tileLength
        self.grids = Grids()
        super.init(urlTemplate: nil)
    }

    /**
     * Initialize
     *
     * @param types   grids types to enable
     */
    public init(_ types: [GridType]) {
        let tileLength = TileUtils.tileLength()
        self.tileWidth = tileLength
        self.tileHeight = tileLength
        self.grids = Grids(types)
        super.init(urlTemplate: nil)
    }

    /**
     * Initialize
     *
     * @param grids   grids
     */
    public init(_ grids: Grids) {
        let tileLength = TileUtils.tileLength()
        self.tileWidth = tileLength
        self.tileHeight = tileLength
        self.grids = grids
        super.init(urlTemplate: nil)
    }

    /**
     * Initialize
     *
     * @param tileLength tile width and height
     */
    public init(_ tileLength: Int) {
        self.tileWidth = tileLength
        self.tileHeight = tileLength
        self.grids = Grids()
        super.init(urlTemplate: nil)
    }
    
    /**
     * Initialize
     *
     * @param tileLength tile width and height
     * @param types      grids types to enable
     */
    public init(_ tileLength: Int, _ types: [GridType]) {
        self.tileWidth = tileLength
        self.tileHeight = tileLength
        self.grids = Grids(types)
        super.init(urlTemplate: nil)
    }
    
    /**
     * Initialize
     *
     * @param tileLength tile width and height
     * @param grids      grids
     */
    public init(_ tileLength: Int, _ grids: Grids) {
        self.tileWidth = tileLength
        self.tileHeight = tileLength
        self.grids = grids
        super.init(urlTemplate: nil)
    }
    
    /**
     * Initialize
     *
     * @param tileWidth  tile width
     * @param tileHeight tile height
     */
    public init(_ tileWidth: Int, _ tileHeight: Int) {
        self.tileWidth = tileWidth
        self.tileHeight = tileHeight
        self.grids = Grids()
        super.init(urlTemplate: nil)
    }
    
    /**
     * Initialize
     *
     * @param tileWidth  tile width
     * @param tileHeight tile height
     * @param types      grids types to enable
     */
    public init(_ tileWidth: Int, _ tileHeight: Int, _ types: [GridType]) {
        self.tileWidth = tileWidth
        self.tileHeight = tileHeight
        self.grids = Grids(types)
        super.init(urlTemplate: nil)
    }
    
    /**
     * Initialize
     *
     * @param tileWidth  tile width
     * @param tileHeight tile height
     * @param grids      grids
     */
    public init(_ tileWidth: Int, _ tileHeight: Int, _ grids: Grids) {
        self.tileWidth = tileWidth
        self.tileHeight = tileHeight
        self.grids = grids
        super.init(urlTemplate: nil)
    }
    
    public override func url(forTilePath path: MKTileOverlayPath) -> URL {
        return URL(fileURLWithPath: "")
    }
    
    public override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        
        DispatchQueue.global(qos: .default).async { [self] in

            var tileData: Data? = tile(path.x, path.y, path.z)
            
            if tileData == nil {
                tileData = Data()
            }
            result(tileData, nil)
            
        }
        
    }
    
    /**
     * Get the grid
     *
     * @param type grid type
     * @return grid
     */
    public func grid(_ type: GridType) -> Grid {
        return grids.grid(type)
    }

    /**
     * Get the Global Area Reference System coordinate for the location coordinate in five
     * minute precision
     *
     * @param coordinate location
     * @return GARS coordinate
     */
    public func coordinate(_ coordinate: CLLocationCoordinate2D) -> String {
        return gars(coordinate).coordinate()
    }

    /**
     * Get the Global Area Reference System coordinate for the MapKit map point in five
     * minute precision
     *
     * @param point MapKit map point
     * @return GARS coordinate
     */
    public func coordinate(_ point: MKMapPoint) -> String {
        return coordinate(TileUtils.toCoordinate(point))
    }
    
    /**
     * Get the Global Area Reference System coordinate for the location coordinate in the
     * zoom level precision
     *
     * @param coordinate location
     * @param zoom   zoom level precision
     * @return GARS coordinate
     */
    public func coordinate(_ coordinate: CLLocationCoordinate2D, _ zoom: Int) -> String {
        return self.coordinate(coordinate, precision(zoom))
    }

    /**
     * Get the Global Area Reference System coordinate for the MapKit map point in the
     * zoom level precision
     *
     * @param point MapKit map point
     * @param zoom   zoom level precision
     * @return GARS coordinate
     */
    public func coordinate(_ point: MKMapPoint, _ zoom: Int) -> String {
        return coordinate(TileUtils.toCoordinate(point), zoom)
    }
    
    /**
     * Get the Global Area Reference System coordinate for the location coordinate in the
     * grid type precision
     *
     * @param coordinate location
     * @param type   grid type precision
     * @return GARS coordinate
     */
    public func coordinate(_ coordinate: CLLocationCoordinate2D, _ type: GridType?) -> String {
        return gars(coordinate).coordinate(type)
    }
    
    /**
     * Get the Global Area Reference System coordinate for the MapKit map point in the
     * grid type precision
     *
     * @param point MapKit map point
     * @param type   grid type precision
     * @return GARS coordinate
     */
    public func coordinate(_ point: MKMapPoint, _ type: GridType?) -> String {
        return coordinate(TileUtils.toCoordinate(point), type)
    }

    /**
     * Get the Global Area Reference System for the location coordinate
     *
     * @param coordinate location
     * @return GARS
     */
    public func gars(_ coordinate: CLLocationCoordinate2D) -> GARS {
        return GARS.from(coordinate)
    }
    
    /**
     * Get the Global Area Reference System for the MapKit map point
     *
     * @param point MapKit map point
     * @return GARS
     */
    public func gars(_ point: MKMapPoint) -> GARS {
        return gars(TileUtils.toCoordinate(point))
    }
    
    /**
     * Parse a GARS string
     *
     * @param gars
     *            GARS string
     * @return GARS
     */
    public static func parse(_ gars: String) -> GARS {
        return GARS.parse(gars)
    }

    /**
     * Parse a GARS string into a location coordinate
     *
     * @param gars
     *            GARS string
     * @return coordinate
     */
    public static func parseToCoordinate(_ gars: String) -> CLLocationCoordinate2D {
        return GARS.parseToCoordinate(gars)
    }

    /**
     * Get the grid precision for the zoom level
     *
     * @param zoom zoom level
     * @return grid type precision
     */
    public func precision(_ zoom: Int) -> GridType? {
        return grids.precision(zoom)
    }

    /**
     * Get the tile
     *
     * @param x    x coordinate
     * @param y    y coordinate
     * @param zoom zoom level
     * @return image
     */
    public func tile(_ x: Int, _ y: Int, _ zoom: Int) -> Data? {
        return TileUtils.toData(drawTile(x, y, zoom))
    }

    /**
     * Draw the tile
     *
     * @param x    x coordinate
     * @param y    y coordinate
     * @param zoom zoom level
     * @return image
     */
    public func drawTile(_ x: Int, _ y: Int, _ zoom: Int) -> UIImage? {
        return grids.drawTile(tileWidth, tileHeight, x, y, zoom)
    }
    
}
