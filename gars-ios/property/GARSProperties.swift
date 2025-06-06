//
//  GARSProperties.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/9/22.
//

import Foundation
import Grid

/**
 * GARS property loader
 */
public class GARSProperties: GridProperties {
    
    /**
     * Properties Name
     */
    public static let PROPERTIES_NAME = "gars"
    
    /**
     * Singleton instance
     */
    private static let _instance: GARSProperties = {
        guard let url = Bundle.module.url(forResource: PROPERTIES_NAME, withExtension: PropertyConstants.PROPERTY_LIST_TYPE) else {
            fatalError("Unable to find required resource: \(PROPERTIES_NAME).\(PropertyConstants.PROPERTY_LIST_TYPE)")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load required resource: \(url)")
        }
        return GARSProperties(data)
    }()
    
    public static var instance: GARSProperties {
        get {
            return _instance
        }
    }

}
