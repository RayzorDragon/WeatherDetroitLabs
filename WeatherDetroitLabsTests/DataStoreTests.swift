//
//  DataStoreTests.swift
//  WeatherDetroitLabsTests
//
//  Created by Raymond Gatz on 6/22/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import XCTest
@testable import WeatherDetroitLabs

class DataStoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testUpdateCurrent() {
		let current = try! JSONDecoder().decode(CurrentWeather.self, from: TestConstant.goodCurrentJSON.data(using: .utf8)!)
		
		let notificationExpection = expectation(description: "Notification Raised")
		let sub = NotificationCenter.default.addObserver(forName: Constants.currentNotification.name, object: nil, queue: nil) { (notification) in
			notificationExpection.fulfill()
		}
		DataStore.sharedInstance.updateCurrent(update: current)
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(DataStore.sharedInstance.currentWeather)
		}
		NotificationCenter.default.removeObserver(sub)
	}
	
	func testUpdateForecast() {
		let current = try! JSONDecoder().decode(FiveDayWeather.self, from: TestConstant.goodForecastJSON.data(using: .utf8)!)
		
		let notificationExpection = expectation(description: "Notification Raised")
		let sub = NotificationCenter.default.addObserver(forName: Constants.currentNotification.name, object: nil, queue: nil) { (notification) in
			notificationExpection.fulfill()
		}
		DataStore.sharedInstance.updateForecast(update: current)
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(DataStore.sharedInstance.forecastWeather)
		}
		NotificationCenter.default.removeObserver(sub)
	}

}
