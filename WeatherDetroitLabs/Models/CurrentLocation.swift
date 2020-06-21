//
//  CurrentLocation.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocation {
	private var locationManager: LocationManager
	var location: CLLocationCoordinate2D?
	init(mock: Bool = false) {
		if mock { locationManager = MockLocationManager() }
		else { locationManager = CLLocationManager() }
		locationManager.requestWhenInUseAuthorization()
		if (locationManager.getAuthorizationStatus() == .authorizedWhenInUse || locationManager.getAuthorizationStatus() == .authorizedAlways ) {
			self.location = locationManager.location?.coordinate
		}
	}
}
