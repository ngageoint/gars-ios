# GARS iOS

#### Global Area Reference System Lib ####

The GARS Library was developed at the [National Geospatial-Intelligence Agency (NGA)](http://www.nga.mil/) in collaboration with [BIT Systems](https://www.caci.com/bit-systems/). The government has "unlimited rights" and is releasing this software to increase the impact of government investments by providing developers with the opportunity to take things in new directions. The software use, modification, and distribution rights are stipulated within the [MIT license](http://choosealicense.com/licenses/mit/).

### Pull Requests ###
If you'd like to contribute to this project, please make a pull request. We'll review the pull request and discuss the changes. All pull request contributions to this project will be released under the MIT license.

Software source code previously released under an open source license and then modified by NGA staff is considered a "joint work" (see 17 USC § 101); it is partially copyrighted, partially public domain, and as a whole is protected by the copyrights of the non-government authors and must be released according to the terms of the original open source license.

### About ###

[GARS](http://ngageoint.github.io/gars-ios/) is a Swift library providing Global Area Reference System functionality, a standardized geospatial reference system for areas.

### Usage ###

View the latest [Appledoc](http://ngageoint.github.io/gars-ios/docs/api/)

```swift

TODO

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
