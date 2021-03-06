//
//  CLLocationManager+Extension.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationManager: LocationManager {
	func getAuthorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
	
	func changeLocation(lat: Double, lon: Double) {
		// This exists only for testing and should not be used in production
	}
}
