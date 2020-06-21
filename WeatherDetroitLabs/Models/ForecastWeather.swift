//
//  ForecastWeather.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class ForecastWeather: CustomStringConvertible, Decodable {
	var weather: [Weather]
	var main: Main
	var dt_txt: String
	
	var description: String {
		return """
		dateTime: \(dt_txt)
		temperature: \(main.temp)
		icon: \(weather.first?.icon)
		"""
	}
	
	init(weather: [Weather], main: Main, dateTime: String) {
		self.weather = weather
		self.main = main
		self.dt_txt = dateTime
	}
}
