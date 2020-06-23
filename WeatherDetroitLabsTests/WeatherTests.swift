//
//  WeatherTests.swift
//  WeatherDetroitLabsTests
//
//  Created by Raymond Gatz on 6/23/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import XCTest
@testable import WeatherDetroitLabs

class WeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIconURL() throws {
		let weather = try! JSONDecoder().decode(Weather.self, from: TestConstant.goodWeatherJSON.data(using: .utf8)!)
		
		let iconURL = weather.iconURLString
		XCTAssertEqual(iconURL, "http://openweathermap.org/img/wn/10d@2x.png", "iconURL does not match ")
    }


}
