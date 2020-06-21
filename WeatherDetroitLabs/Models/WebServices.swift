//
//  WebServices.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class WebServices {
	var session: URLSession!
	var location: CurrentLocation!
	
	func getCurrentTemperature(completion: @escaping (CurrentWeather?, Error?) -> Void) {
		guard let url = buildCurrentTempURL() else { fatalError() }
		session.dataTask(with: url) { (data, response, error) in
			
			guard error == nil else {
				completion(nil, error)
				return
			}
			
			guard let data = data else {
				completion(nil, NSError(domain: "no data", code: 10, userInfo: nil))
				return
			}
			
			do {
				let currentTemp = try JSONDecoder().decode(CurrentWeather.self, from: data)
				completion(currentTemp, nil)
			} catch {
				completion(nil, error)
			}
		}.resume()
	}
	
	func getForecastTemperature(completion: @escaping (FiveDayWeather?, Error?) -> Void) {
		guard let url = buildForecastTempURL() else { fatalError() }
		session.dataTask(with: url) { (data, response, error) in
			
			guard error == nil else {
				completion(nil, error)
				return
			}
			
			guard let data = data else {
				completion(nil, NSError(domain: "no data", code: 10, userInfo: nil))
				return
			}
			do {
				let forecastTemp = try JSONDecoder().decode(FiveDayWeather.self, from: data)
				completion(forecastTemp, nil)
			} catch {
				completion(nil, error)
			}
		}.resume()
	}
	
	private func buildCurrentTempURL() -> URL? {
		var urlString = Constants().openWeatherCurrentURL
		urlString.append(self.allQueryComponents())
		
		return URL(string: urlString)
	}
	
	private func buildForecastTempURL() -> URL? {
		var urlString = Constants().openWeatherForcastURL
		urlString.append(self.allQueryComponents())
		
		return URL(string: urlString)
	}
	
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
		return "appid=\(Constants().openWeatherAPIKey)"
	}
	
	private func buildUnitQueryComponent() -> String {
		return "units=imperial"
	}
}
