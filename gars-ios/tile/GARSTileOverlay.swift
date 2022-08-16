//
//  GARSTileOverlay.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/15/22.
//

import MapKit

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
            
            if(tileData == nil){
                tileData = Data()
            }
            result(tileData, nil)
            
        }
        
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
