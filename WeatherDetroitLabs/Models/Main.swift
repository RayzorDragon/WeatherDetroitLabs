//
//  Main.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class Main: CustomStringConvertible, Decodable {
	
	var temp: Double
	
	var description: String {
		return """
		Temp: \(temp)
		"""
	}
	
	init(temp: Double) {
		self.temp = temp
	}
}
