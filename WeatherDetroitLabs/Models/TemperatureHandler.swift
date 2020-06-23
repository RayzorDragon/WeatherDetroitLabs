//
//  TemperatureHandler.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/22/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

enum TemperatureScale {
	case fahrenheit
}

class TemperatureHandler {
	// appends the proper temperature scale symbol to a value for a string
	static func temperatureString(temp: Double, scale: TemperatureScale) -> String {
		var tempString = "\(temp)"
		
		switch scale {
		case .fahrenheit:
			tempString.append(Constants.fahrenheitSymbol)
		}
		
		return tempString
	}
}
