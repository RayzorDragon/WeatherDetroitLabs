//
//  Constants.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

struct Constants {
	static let openWeatherAPIKey = "9207c312ec1e26dbc9319f5cf4fd10d1"
	static let openWeatherCurrentURL = "http://api.openweathermap.org/data/2.5/weather?"
	static let openWeatherForcastURL = "http://api.openweathermap.org/data/2.5/forecast?"
	static let openWeatherIconURL = "http://openweathermap.org/img/wn/"
	static let openWeatherIconURLSuffix = "@2x.png"
	
	static let fahrenheitSymbol = "°F"
	
	static let noGeoServiceWarning = "N/A: No Geolocation Detected"
	
	static let currentNotification = Notification(name: Notification.Name("currentNotification"))
	static let forecastNotification = Notification(name: Notification.Name("forecastNotification"))
	static let locationNotification = Notification(name: Notification.Name("locationNotification"))
	
}
