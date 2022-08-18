//
//  ContentView.swift
//  app
//
//  Created by Brian Osborn on 8/18/22.
//

import SwiftUI
import MapKit
import gars_ios

struct ContentView: View {
    var body: some View {
        MapView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MapView: UIViewRepresentable {
  
  var locationManager = CLLocationManager()
  let mapViewDelegate = MapViewDelegate()
    
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    setupManager()
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
      
    return mapView
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
      view.delegate = mapViewDelegate
      view.translatesAutoresizingMaskIntoConstraints = false
      let tileOverlay = GARSTileOverlay()
      tileOverlay.canReplaceMapContent = false
      view.addOverlay(tileOverlay)
  }
    
}

class MapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKTileOverlayRenderer(overlay: overlay)
        return renderer
    }
}
