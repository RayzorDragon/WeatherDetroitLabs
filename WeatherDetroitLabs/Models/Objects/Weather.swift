//
//  Weather.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class Weather: CustomStringConvertible, Decodable {

	var icon: String
	
	var description: String {
		return """
		Icon: \(icon)
		"""
	}
	
	var iconURLString: String {
		var urlString = Constants.openWeatherIconURL
		urlString.append(icon)
		urlString.append(Constants.openWeatherIconURLSuffix)
		return urlString
	}
	
	init(icon: String) {

		self.icon = icon
	}
	
	
}

extension Weather: Equatable {
	static func == (lhs: Weather, rhs: Weather) -> Bool {
		lhs.icon == rhs.icon
	}
}
