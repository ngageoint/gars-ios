//
//  ContentView.swift
//  app
//
//  Created by Brian Osborn on 8/18/22.
//

import SwiftUI
import MapKit
import gars_ios
import grid_ios

struct ContentView: View {
    
    @ObservedObject var coordinate: Coordinate = Coordinate()
    
    var body: some View {
        VStack {
            MapView(coordinate)
            HStack {
                Text(coordinate.garsLabel)
                Spacer()
                Text(coordinate.wgs84Label)
                Spacer()
                Text(coordinate.zoomLabel)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Coordinate: ObservableObject{
    @Published var garsLabel = ""
    @Published var wgs84Label = ""
    @Published var zoomLabel = ""
}

struct MapView: UIViewRepresentable {
  
    let mapView = MKMapView()
    var coordinate: Coordinate
    var tileOverlay: GARSTileOverlay
  
    public init(_ coordinate: Coordinate) {
        self.coordinate = coordinate
        tileOverlay = GARSTileOverlay()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        mapView.delegate = context.coordinator
        mapView.addOverlay(tileOverlay)
        
        // double tap recognizer has no action
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: nil)
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        mapView.addGestureRecognizer(doubleTapRecognizer)
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.singleTapGesture(tapGestureRecognizer:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.numberOfTouchesRequired = 1
        singleTapGestureRecognizer.delaysTouchesBegan = true
        singleTapGestureRecognizer.cancelsTouchesInView = true
        singleTapGestureRecognizer.delegate = context.coordinator
        singleTapGestureRecognizer.require(toFail: doubleTapRecognizer)
        mapView.addGestureRecognizer(singleTapGestureRecognizer)
        
        return mapView
    }
  
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(mapView, coordinate, tileOverlay)
    }
    
}

class MapViewCoordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    var mapView: MKMapView
    var coordinate: Coordinate
    var overlay: GARSTileOverlay
    var centerAdded: Bool = false
    
    public init(_ mapView: MKMapView, _ coordinate: Coordinate, _ overlay: GARSTileOverlay) {
        self.mapView = mapView
        self.coordinate = coordinate
        self.overlay = overlay
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        addCenter(mapView)
    }

    func addCenter(_ uiView: MKMapView) {
        if !centerAdded && uiView.frame.size.height > 0 {
            let image = UIImageView(image: UIImage(named: "center")?.image(alpha: 0.25))
            image.isUserInteractionEnabled = false
            image.center = CGPoint(x: uiView.frame.size.width/2, y: uiView.frame.size.height/2)
            uiView.addSubview(image)
            centerAdded = true
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKTileOverlayRenderer(overlay: overlay)
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        let zoom = TileUtils.currentZoom(mapView)
        coordinate.wgs84Label = String(format: "%.5f", center.longitude) + "," + String(format: "%.5f", center.latitude)
        coordinate.garsLabel = overlay.coordinate(center, Int(zoom))
        coordinate.zoomLabel = String(format: "%.1f", trunc(zoom * 10) / 10)
    }
    
    @objc func singleTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        if tapGestureRecognizer.state == .ended {
            self.mapTap(tapGestureRecognizer.location(in: mapView), tapGestureRecognizer)
        }
    }
    
    func mapTap(_ tapPoint:CGPoint, _ gesture: UITapGestureRecognizer) {
        let tapCoord = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        mapView.setCenter(tapCoord, animated: true)
    }
    
}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
