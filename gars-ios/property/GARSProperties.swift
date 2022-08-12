//
//  GARSProperties.swift
//  gars-ios
//
//  Created by Brian Osborn on 8/9/22.
//

import Foundation
import grid_ios

/**
 * GARS property loader
 */
public class GARSProperties: GridProperties {
    
    /**
     * Bundle Name
     */
    public static let BUNDLE_NAME = "gars-ios.bundle"
    
    /**
     * Properties Name
     */
    public static let PROPERTIES_NAME = "gars"
    
    /**
     * Singleton instance
     */
    private static let _instance = GARSProperties(BUNDLE_NAME, PROPERTIES_NAME)
    
    public static var instance: GARSProperties {
        get {
            return _instance
        }
    }
    
}
