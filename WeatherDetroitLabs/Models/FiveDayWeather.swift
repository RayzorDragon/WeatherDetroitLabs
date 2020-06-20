//
//  FiveDayWeather.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class FiveDayWeather: CustomStringConvertible, Decodable {
	var list: [ForecastWeather]
	
	var description: String {
		var descript = """
		List:
		"""
		for forecast in list {
			descript = descript + "\n" + forecast.description
		}
		return descript
	}
	
	init(list: [ForecastWeather]) {
		self.list = list
	}
}
