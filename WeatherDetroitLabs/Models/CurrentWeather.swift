//
//  CurrentWeather.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class CurrentWeather: CustomStringConvertible, Decodable {
	var main: Main
	
	var description: String {
		return """
		Current Temperature: \(main.temp)
		"""
	}
}
