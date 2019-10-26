//
//  Geolocation.swift
//  MusicPlaces
//
//  Created by Alejandro Mendoza on 25/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import Foundation
import FirebaseFirestore
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    
    func setupLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func the(point: CLLocationCoordinate2D, are inPoint: CLLocationCoordinate2D) -> Bool {
        let region = CLCircularRegion(center: inPoint, radius: 20.0, identifier: "region")
        return region.contains(point)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
    }
    
    func getLocationNameOf(_ location: CLLocation) {
        let geocode = CLGeocoder()

        geocode.reverseGeocodeLocation(location) { (placemarks, _) in
            if let placemarks = placemarks, let placemark = placemarks.first {
                self.locationName = placemark.name
                self.locationAdministrativeArea = placemark.administrativeArea
            }
        }
    }
    
}

extension CLLocationCoordinate2D {
    init(cordinate: GeoPoint) {
        self.init()
        self.latitude = cordinate.latitude
        self.longitude = cordinate.longitude
    }
}
