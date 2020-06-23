//
//  WebServices.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class WebServices {
	private let networkService: Network
	var session: URLSession
	var location: CurrentLocation
	
	init(session: URLSession, location: CurrentLocation) {
		self.session = session
		self.networkService = Network.init(session: session)
		self.location = location
		NotificationCenter.default.addObserver(self, selector: #selector(loadAllData), name: Constants.locationNotification.name, object: nil)
	}
	
	@objc private func loadAllData() {
		getCurrentTemperature { (currentWeather, error) in
			DataStore.sharedInstance.updateCurrent(update: currentWeather)
		}
		getForecastTemperature { (fiveDayWeather, error) in
			DataStore.sharedInstance.updateForecast(update: fiveDayWeather)
		}
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	func getCurrentTemperature(completion: @escaping (CurrentWeather?, Error?) -> Void) {
		guard let url = buildCurrentTempURL() else {
			completion(nil, NetworkError.invalidURL)
			return
		}
		networkService.loadDataFromWeb(url: url, type: CurrentWeather.self) { (currentWeather, error) in
			completion(currentWeather, error)
			return
		}
	}
	
	func getForecastTemperature(completion: @escaping (FiveDayWeather?, Error?) -> Void) {
		guard let url = buildForecastTempURL() else {
			completion(nil, NetworkError.invalidURL)
			return
		}
		
		networkService.loadDataFromWeb(url: url, type: FiveDayWeather.self) { (forecast, error) in
			completion(forecast, error)
			return
		}
	}
	
	// MARK: - Build URLs
	
	private func buildCurrentTempURL() -> URL? {
		var urlString = Constants.openWeatherCurrentURL
		urlString.append(self.allQueryComponents())
		
		return URL(string: urlString)
	}
	
	private func buildForecastTempURL() -> URL? {
		var urlString = Constants.openWeatherForcastURL
		urlString.append(self.allQueryComponents())
		
		return URL(string: urlString)
	}
	
	// MARK: - Query components for URLs
	
	private func allQueryComponents() -> String {
		var queries = ""
		if let locQuerry = self.buildLocationQueryComponent() {
			queries.append(locQuerry)
		}
		if !queries.isEmpty { queries.append("&") }
		queries.append(self.buildAPIKeyQueryComponent())
		queries.append("&")
		queries.append(self.buildUnitQueryComponent())
		return queries
	}
	
	private func buildLocationQueryComponent() -> String? {
		var locQuerry: String?
		if let lat = location.location?.latitude, let lon = location.location?.longitude {
			locQuerry = "lat=\(lat)&lon=\(lon)"
		}
		
		return locQuerry
	}
	
	private func buildAPIKeyQueryComponent() -> String {
		return "appid=\(Constants.openWeatherAPIKey)"
	}
	
	private func buildUnitQueryComponent() -> String {
		return "units=imperial"
	}
}
