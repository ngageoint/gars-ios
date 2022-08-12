//
//  GARSLabeler.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/10/22.
//

import Foundation
import grid_ios

/**
 * GARS grid labeler
 */
public class GARSLabeler: GridLabeler {
    
    public override func labels(_ tileBounds: Bounds, _ gridType: GridType) -> [GridLabel] {
        
        var labels = [GridLabel]()

        let precision = gridType.precision()

        let precisionBounds = tileBounds.toPrecision(precision)

        var lon = precisionBounds.minLongitude
        while lon <= precisionBounds.maxLongitude {
            
            var lat = precisionBounds.minLatitude
            while lat <= precisionBounds.maxLatitude {
                
                let bounds = Bounds.degrees(lon, lat, lon + precision, lat + precision)
                let center = bounds.centroid()
                let coordinate = GARS.from(center)

                let name: String

                switch gridType {
                case .TWENTY_DEGREE, .TEN_DEGREE, .FIVE_DEGREE, .ONE_DEGREE:
                    name = GARSUtils.degreeLabel(lon, lat)
                    break
                default:
                    name = coordinate.coordinate(gridType)
                }
                
                labels.append(GridLabel(name, center, bounds, gridType, coordinate))
                
                lat = GARSUtils.nextPrecision(lat, precision)
            }
            
            lon = GARSUtils.nextPrecision(lon, precision)
        }

        return labels
    }
    
}
