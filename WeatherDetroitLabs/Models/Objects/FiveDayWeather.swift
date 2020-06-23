//
//  FiveDayWeather.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class FiveDayWeather: CustomStringConvertible, Decodable {
	/*
	A collection of weather forecasts in the next 5 days seperated by 3 hour
	intervals, each forecast only requires a temperature, the weather icon, and
	the time it's for.
	*/
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

extension FiveDayWeather: Equatable {
	static func == (lhs: FiveDayWeather, rhs: FiveDayWeather) -> Bool {
		lhs.list == rhs.list
	}
	
}
