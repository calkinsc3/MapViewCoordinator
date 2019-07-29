//
//  MapView.swift
//  MapViewCoordinator
//
//  Created by William Calkins on 7/28/19.
//  Copyright © 2019 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var coordinate: CLLocationCoordinate2D
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        context.coordinator.startLocation()
        return MKMapView(frame: .zero)
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    //MARK:- Location Coordinator
    class Coordinator: NSObject {
        
        var parent: MapView
        private let locationManager = LocationManager()
        private var locationManagerObserver : NSKeyValueObservation?
        private var foregroundManagerObserver : NSObjectProtocol?
        
        init(_ mapView: MapView) {
            self.parent = mapView
        }
        
        func startLocation() {
           
            //request permission to location
            locationManager.requestLocation()
            
            //use KVO to listen to location changes
            locationManagerObserver = locationManager.observe((\LocationManager.currentLocation), changeHandler: { [weak self] (locationManager, keyPathObserved) in
                if let location = locationManager.currentLocation {
                    print("given location is \(location.coordinate)")
                    self?.parent.coordinate = location.coordinate
                }
            })
            
            let name = UIApplication.willEnterForegroundNotification
            foregroundManagerObserver = NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil, using: { [weak self](_) in
                //Get a new location when returning from settings
                self?.locationManager.requestLocation()
            })
            
        }
        
        
    }
    
    
}

#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: testCoordinate)
    }
}
#endif
