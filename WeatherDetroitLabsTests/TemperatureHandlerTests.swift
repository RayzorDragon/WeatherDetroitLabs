//
//  TemperatureHandlerTests.swift
//  WeatherDetroitLabsTests
//
//  Created by Raymond Gatz on 6/22/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import XCTest
@testable import WeatherDetroitLabs

class TemperatureHandlerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


	func testWholeNumberToFahrenheit() {
		let temp: Double = 12
		let tempString = TemperatureHandler.temperatureString(temp: temp, scale: .fahrenheit)
		XCTAssertEqual(tempString, "12.0°F", "Temperature string wasn't formatted properly.")
	}
	
	func testNegativeNumberToFahrenheit() {
		let temp: Double = -2
		let tempString = TemperatureHandler.temperatureString(temp: temp, scale: .fahrenheit)
		XCTAssertEqual(tempString, "-2.0°F", "Temperature string wasn't formatted properly.")
	}
	
	func testLargeDecimalNumberToFahrenheit() {
		let temp: Double = 78.9972
		let tempString = TemperatureHandler.temperatureString(temp: temp, scale: .fahrenheit)
		XCTAssertEqual(tempString, "78.9972°F", "Temperature string wasn't formatted properly.")
	}

}
