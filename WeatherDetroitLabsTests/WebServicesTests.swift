//
//  WebServicesTests.swift
//  WeatherDetroitLabsTests
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import XCTest
@testable import WeatherDetroitLabs

class WebServicesTests: XCTestCase {
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testGetCurrentTempWithExpectedURLHostAndPath() {
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getCurrentTemperature { currentWeather, error in }
		XCTAssertEqual(mockURLSession.cachedUrl?.host, "api.openweathermap.org", "URLSession host does not target api.openweathermap.org")
		XCTAssertEqual(mockURLSession.cachedUrl?.path, "/data/2.5/weather", "URLSession path does not target data/2.5/weather")
		XCTAssertEqual(mockURLSession.cachedUrl?.query, "lat=39.7686291&lon=-86.1607217&appid=9207c312ec1e26dbc9319f5cf4fd10d1&units=imperial", "URLSession query does not match expected parameters")
	}
	
	func testGetForecastTempWithExpectedURLHostAndPath() {
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getForecastTemperature { fiveDayWeather, error in }
		XCTAssertEqual(mockURLSession.cachedUrl?.host, "api.openweathermap.org", "URLSession host does not target api.openweathermap.org")
		XCTAssertEqual(mockURLSession.cachedUrl?.path, "/data/2.5/forecast", "URLSession path does not target data/2.5/forecast")
		XCTAssertEqual(mockURLSession.cachedUrl?.query, "lat=39.7686291&lon=-86.1607217&appid=9207c312ec1e26dbc9319f5cf4fd10d1&units=imperial", "URLSession query does not match expected parameters")
	}
	
	func testGetCurrentTempReturnsTemp() {
		let jsonData = TestConstant.goodCurrentJSON.data(using: .utf8)
		let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
		let tempExpecation = expectation(description: "Current Temperature")
		var tempResponse: CurrentWeather?
		
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getCurrentTemperature { (currentWeather, error) in
			tempResponse = currentWeather
			tempExpecation .fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(tempResponse)
		}
	}
	
	func testGetForecastTempReturnsTemp() {
		let jsonData = TestConstant.goodForecastJSON.data(using: .utf8)
		let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)

		let forecastExpecation = expectation(description: "Current Forecast")
		var forecastResponse: FiveDayWeather?
		
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getForecastTemperature { (forecastWeather, error) in
			forecastResponse = forecastWeather
			forecastExpecation .fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(forecastResponse)
		}
	}
	
	func testGetCurrentTempWhenResponseErrorReturnsError() {
		let error = NSError(domain: "error", code: 1234, userInfo: nil)
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: error)
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getCurrentTemperature { (currentWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetForecastTempWhenResponseErrorReturnsError() {
		let error = NSError(domain: "error", code: 1234, userInfo: nil)
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: error)
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getForecastTemperature{ (forecastWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetCurrentTempWhenEmmptyDataReturnsError() {
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getCurrentTemperature { (currentWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetForecastTempWhenEmptyDataReturnsError() {
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getForecastTemperature{ (forecastWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetCurrentTempInvalidJSONReturnsError() {
		let jsonData = TestConstant.badJSON.data(using: .utf8)
		let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getCurrentTemperature { (currentWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetForecastTempINvalidJSONReturnsError() {
		let jsonData = TestConstant.badJSON.data(using: .utf8)
		let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		let webService = WebServices(session: mockURLSession, location: CurrentLocation(mock: true))
		webService.getForecastTemperature{ (forecastWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}

}
