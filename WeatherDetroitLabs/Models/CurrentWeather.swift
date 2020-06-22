//
//  CurrentWeather.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class CurrentWeather: CustomStringConvertible, Decodable {
	/*
	As the only item we care about from the current weather forecast is
	currently the Temperature, we're only decoding the 'Main' item and then
	only the temperature of it
	*/
	var main: Main
	
	var description: String {
		return """
		Current Temperature: \(main.temp)
		"""
	}
}
