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
	
	init(icon: String) {

		self.icon = icon
	}
}
