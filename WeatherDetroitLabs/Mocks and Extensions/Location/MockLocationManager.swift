//
//  MockLocationManager.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation
import CoreLocation

class MockLocationManager: LocationManager {
    var location: CLLocation? = CLLocation(
        latitude: 39.7686291,
        longitude: -86.1607217
	)

    var delegate: CLLocationManagerDelegate?
    var distanceFilter: CLLocationDistance = 10
    var pausesLocationUpdatesAutomatically = false
    var allowsBackgroundLocationUpdates = true

    func requestWhenInUseAuthorization() { }
    func startUpdatingLocation() { }
    func stopUpdatingLocation() { }
	
	func getAuthorizationStatus() -> CLAuthorizationStatus {
        return .authorizedWhenInUse
    }

    func isLocationServicesEnabled() -> Bool {
        return true
    }
	
	func changeLocation(lat: Double, lon: Double) {
		location = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
		delegate?.locationManager?(CLLocationManager(), didUpdateLocations: [location!])
	}
}
