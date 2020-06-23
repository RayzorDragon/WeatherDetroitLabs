//
//  CurrentLocationTests.swift
//  WeatherDetroitLabsTests
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import XCTest
@testable import WeatherDetroitLabs

class CurrentLocationTests: XCTestCase {

	
	var location: CurrentLocation!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		location = CurrentLocation.init(mock: true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testCoordinateFetch() {
		let lat = location.location?.latitude
		let long = location.location?.longitude
		
		XCTAssertEqual(lat, 39.7686291, "Latitude is not 39.7686291") // mock location lat
		XCTAssertEqual(long, -86.1607217, "Longitude is not -86.1607217") // mock location long
	}
	
	func testLocationUpdateNotification() {
		let notificationExpecation = expectation(description: "Notification Raised")
		let sub = NotificationCenter.default.addObserver(forName: Constants.locationNotification.name, object: nil, queue: nil) { (notification) in
			notificationExpecation.fulfill()
		}
		location.locManager.changeLocation(lat: 39.0, lon: -86.0)
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(self.location.location)
			
			let lat = self.location.location?.latitude
			let long = self.location.location?.longitude
			
			XCTAssertEqual(lat, 39.0, "Latitude is not 39.0")
			XCTAssertEqual(long, -86.0, "Longitude is not -86.0")
		}
		NotificationCenter.default.removeObserver(sub)
	}

}
