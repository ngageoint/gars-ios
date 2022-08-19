# GARS iOS

#### Global Area Reference System Lib ####

The GARS Library was developed at the [National Geospatial-Intelligence Agency (NGA)](http://www.nga.mil/) in collaboration with [BIT Systems](https://www.caci.com/bit-systems/). The government has "unlimited rights" and is releasing this software to increase the impact of government investments by providing developers with the opportunity to take things in new directions. The software use, modification, and distribution rights are stipulated within the [MIT license](http://choosealicense.com/licenses/mit/).

### Pull Requests ###
If you'd like to contribute to this project, please make a pull request. We'll review the pull request and discuss the changes. All pull request contributions to this project will be released under the MIT license.

Software source code previously released under an open source license and then modified by NGA staff is considered a "joint work" (see 17 USC § 101); it is partially copyrighted, partially public domain, and as a whole is protected by the copyrights of the non-government authors and must be released according to the terms of the original open source license.

### About ###

[GARS](http://ngageoint.github.io/gars-ios/) is a Swift library providing Global Area Reference System functionality, a standardized geospatial reference system for areas.  [GARS App](https://github.com/ngageoint/gars-ios/tree/master/app) is a map implementation utilizing this library.

### Usage ###

View the latest [Appledoc](http://ngageoint.github.io/gars-ios/docs/api/)

#### Coordinates ####

```swift

let gars = GARS.parse("006AG39")
let point = gars.toPoint()
let pointMeters = point.toMeters()

let latitude = 63.98862388
let longitude = 29.06755082
let point2 = GridPoint(longitude, latitude)
let gars2 = GARS.from(point2)
let garsCoordinate = gars2.description
let gars30m = gars2.coordinate(GridType.THIRTY_MINUTE)
let gars15m = gars2.coordinate(GridType.FIFTEEN_MINUTE)
let gars5m = gars2.coordinate(GridType.FIVE_MINUTE)

```

#### Tile Overlay ####

```swift

// let mapView: MKMapView = ...

// Tile size determined from display density
let tileOverlay = GARSTileOverlay()

// Manually specify tile size
let tileOverlay2 = GARSTileOverlay(512, 512)

// Specified grids
let customTileOverlay = GARSTileOverlay(
        [GridType.THIRTY_MINUTE, GridType.FIFTEEN_MINUTE])

mapView.addOverlay(tileOverlay)

```

#### Tile Overlay Options ####

```swift

let tileOverlay = GARSTileOverlay()

let x = 8
let y = 12
let zoom = 5

// Manually get a tile or draw the tile bitmap
let tile = tileOverlay.tile(x, y, zoom)
let tileImage = tileOverlay.drawTile(x, y, zoom)

let latitude = 63.98862388
let longitude = 29.06755082
let locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude)

// GARS Coordinates
let gars = tileOverlay.gars(locationCoordinate)
let coordinate = tileOverlay.coordinate(locationCoordinate)
let zoomCoordinate = tileOverlay.coordinate(locationCoordinate, zoom)

let gars30m = tileOverlay.coordinate(locationCoordinate, GridType.THIRTY_MINUTE)
let gars15m = tileOverlay.coordinate(locationCoordinate, GridType.FIFTEEN_MINUTE)
let gars5m = tileOverlay.coordinate(locationCoordinate, GridType.FIVE_MINUTE)

```

#### Custom Grids ####

```swift

let grids = Grids()

grids.deletePropagatedStyles()
grids.disableTypes([GridType.TWENTY_DEGREE, GridType.TEN_DEGREE,
        GridType.FIVE_DEGREE, GridType.ONE_DEGREE])

grids.setColor(GridType.THIRTY_MINUTE, UIColor.red)
grids.setWidth(GridType.THIRTY_MINUTE, 4.0)
grids.setMinZoom(GridType.THIRTY_MINUTE, 6)

grids.setLabelMinZoom(GridType.THIRTY_MINUTE, 6)
grids.setLabelTextSize(GridType.THIRTY_MINUTE, 32.0)

grids.setColor(GridType.FIFTEEN_MINUTE, UIColor.blue)
let lessThan15m = GridType.lessPrecise(GridType.FIFTEEN_MINUTE)
grids.setWidth(GridType.FIFTEEN_MINUTE, lessThan15m, 4.0)
grids.setColor(GridType.FIFTEEN_MINUTE, lessThan15m, UIColor.red)

grids.setLabelColor(GridType.FIVE_MINUTE, UIColor.orange)
grids.setLabelBuffer(GridType.FIVE_MINUTE, 0.1)
grids.setWidth(GridType.FIVE_MINUTE, lessThan15m, 4.0)
grids.setColor(GridType.FIVE_MINUTE, lessThan15m, UIColor.red)
grids.setColor(GridType.FIVE_MINUTE, GridType.FIFTEEN_MINUTE, UIColor.blue)

let tileOverlay = GARSTileOverlay(grids)

```

#### Draw Tile Template ####

```swift

// let tile: GridTile = ...

let grids = Grids()

let zoomGrids = grids.grids(tile.zoom)
if zoomGrids.hasGrids() {

    for grid in zoomGrids {

        let lines = grid.lines(tile)
        if lines != nil {
            for line in lines! {
                let pixel1 = line.point1.pixel(tile)
                let pixel2 = line.point2.pixel(tile)
                // Draw line
            }
        }

        let labels = grid.labels(tile)
        if labels != nil {
            for label in labels! {
                let pixelRange = label.bounds.pixelRange(tile)
                let centerPixel = label.center.pixel(tile)
                // Draw label
            }
        }

    }
}

```

### Build ###

[![Build & Test](https://github.com/ngageoint/gars-ios/workflows/Build%20&%20Test/badge.svg)](https://github.com/ngageoint/gars-ios/actions/workflows/build-test.yml)

Build this repository using Xcode and/or CocoaPods:

    pod install

Open gars-ios.xcworkspace in Xcode or build from command line:

    xcodebuild -workspace 'gars-ios.xcworkspace' -scheme gars-ios build

Run tests from Xcode or from command line:

    xcodebuild test -workspace 'gars-ios.xcworkspace' -scheme gars-ios -destination 'platform=iOS Simulator,name=iPhone 12'

### Include Library ###

Include this repository by specifying it in a Podfile using a supported option.

Pull from [CocoaPods](https://cocoapods.org/pods/gars-ios):

    pod 'gars-ios', '~> 1.0.0'

Pull from GitHub:

    pod 'gars-ios', :git => 'https://github.com/ngageoint/gars-ios.git', :branch => 'master'
    pod 'gars-ios', :git => 'https://github.com/ngageoint/gars-ios.git', :tag => '1.0.0'

Include as local project:

    pod 'gars-ios', :path => '../gars-ios'

### Remote Dependencies ###

* [Grid](https://github.com/ngageoint/grid-ios) (The MIT License (MIT)) - Grid Library

### GARS App ###

The [GARS App](https://github.com/ngageoint/gars-ios/tree/master/app) provides a Global Area Reference System map using this library.
