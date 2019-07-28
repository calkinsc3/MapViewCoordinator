//
//  LocationManager.swift
//  MapViewCoordinator
//
//  Created by William Calkins on 7/28/19.
//  Copyright © 2019 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager: NSObject {
        
    private let locationManager = CLLocationManager()
    
    @objc dynamic var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            //TODO:- create alert
            return
        }
        
        let status = CLLocationManager.authorizationStatus()
        guard status != .denied else {
            //TODO:- create alert
            return
        }
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
}

extension LocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //handle this later
    }
}
