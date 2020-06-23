//
//  CurrentLocation.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation
import CoreLocation

/*
rather than just utilizing CLLocationManager, this allows for a testable and
mockable system to also be used if desired.
*/
class CurrentLocation: NSObject {
	private var locationManager: LocationManager
	var locManager: LocationManager {
		get {
			return self.locationManager
		}
	}
	var location: CLLocationCoordinate2D? {
		didSet {
			NotificationCenter.default.post(Constants.locationNotification)
		}
	}
	init(mock: Bool = false) {
		if mock { locationManager = MockLocationManager() }
		else { locationManager = CLLocationManager() }
		super.init()
		
		locationManager.delegate = self
		if (locationManager.getAuthorizationStatus() == .authorizedWhenInUse || locationManager.getAuthorizationStatus() == .authorizedAlways ) {
			self.location = locationManager.location?.coordinate
		} else {
			locationManager.requestWhenInUseAuthorization()
		}
	}
}

extension CurrentLocation: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .authorizedWhenInUse, .authorizedAlways:
			self.location = locationManager.location?.coordinate
		default:
			break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		self.location = locations.last?.coordinate
	}
	
}
