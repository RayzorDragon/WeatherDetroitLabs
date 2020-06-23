//
//  DataStore.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/22/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class DataStore {
	static let sharedInstance = DataStore()
	
	private var current: CurrentWeather?
	private var forecast: FiveDayWeather?
	
	// in order to prevent alterations to data, only getters will be exposed as variables.
	var currentWeather: CurrentWeather? {
		get {
			return self.current
		}
	}
	
	var forecastWeather: FiveDayWeather? {
		get {
			return self.forecast
		}
	}
	
	// prevents multiple DataStores and only allows for our sharedInstance to exist.
	private init() {}
	
	// to update data, update functions will be used.
	func updateCurrent(update: CurrentWeather?) {
		self.current = update
		NotificationCenter.default.post(Constants.currentNotification)
	}
	
	func updateForecast(update: FiveDayWeather?) {
		self.forecast = update
		NotificationCenter.default.post(Constants.forecastNotification)
	}
	
	
}
