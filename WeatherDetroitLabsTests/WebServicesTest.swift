//
//  WebServicesTest.swift
//  WeatherDetroitLabsTests
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import XCTest
@testable import WeatherDetroitLabs

class WebServicesTest: XCTestCase {

	let webServices = WebServices()
	let location = CurrentLocation.init(mock: true)
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testGetCurrentTempWithExpectedURLHostAndPath() {
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
		self.webServices.session = mockURLSession
		self.webServices.location = location
		self.webServices.getCurrentTemperature { currentWeather, error in }
		XCTAssertEqual(mockURLSession.cachedUrl?.host, "api.openweathermap.org", "URLSession host does not target api.openweathermap.org")
		XCTAssertEqual(mockURLSession.cachedUrl?.path, "/data/2.5/weather", "URLSession path does not target data/2.5/weather")
		XCTAssertEqual(mockURLSession.cachedUrl?.query, "lat=39.7686291&lon=-86.1607217&appid=9207c312ec1e26dbc9319f5cf4fd10d1&units=imperial", "URLSession query does not match expected parameters")
	}
	
	func testGetForecastTempWithExpectedURLHostAndPath() {
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
		self.webServices.session = mockURLSession
		self.webServices.location = location
		self.webServices.getForecastTemperature { fiveDayWeather, error in }
		XCTAssertEqual(mockURLSession.cachedUrl?.host, "api.openweathermap.org", "URLSession host does not target api.openweathermap.org")
		XCTAssertEqual(mockURLSession.cachedUrl?.path, "/data/2.5/forecast", "URLSession path does not target data/2.5/forecast")
		XCTAssertEqual(mockURLSession.cachedUrl?.query, "lat=39.7686291&lon=-86.1607217&appid=9207c312ec1e26dbc9319f5cf4fd10d1&units=imperial", "URLSession query does not match expected parameters")
	}
	
	func testGetCurrentTempReturnsTemp() {
		let jsonData = "{\"coord\":{\"lon\":-86.16,\"lat\":39.77},\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate rain\",\"icon\":\"10d\"}],\"base\":\"stations\",\"main\":{\"temp\":70.99,\"feels_like\":71.71,\"temp_min\":66.99,\"temp_max\":75.2,\"pressure\":1014,\"humidity\":73},\"visibility\":16093,\"wind\":{\"speed\":5.82,\"deg\":10},\"rain\":{\"1h\":2.54},\"clouds\":{\"all\":90},\"dt\":1592773570,\"sys\":{\"type\":1,\"id\":4533,\"country\":\"US\",\"sunrise\":1592734610,\"sunset\":1592788571},\"timezone\":-14400,\"id\":4259418,\"name\":\"Indianapolis\",\"cod\":200}".data(using: .utf8)
		let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
		self.webServices.session = mockURLSession
		self.webServices.location = location
		let tempExpecation = expectation(description: "Current Temperature")
		var tempResponse: CurrentWeather?
		
		self.webServices.getCurrentTemperature { (currentWeather, error) in
			tempResponse = currentWeather
			tempExpecation .fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(tempResponse)
		}
	}
	
	func testGetForecastTempReturnsTemp() {
		let jsonData = "{\"cod\":\"200\",\"message\":0,\"cnt\":40,\"list\":[{\"dt\":1592784000,\"main\":{\"temp\":69.67,\"feels_like\":71.08,\"temp_min\":68.68,\"temp_max\":69.67,\"pressure\":1013,\"sea_level\":1012,\"grnd_level\":987,\"humidity\":77,\"temp_kf\":0.55},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":95},\"wind\":{\"speed\":4.76,\"deg\":119},\"rain\":{\"3h\":1.32},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-22 00:00:00\"},{\"dt\":1592794800,\"main\":{\"temp\":67.86,\"feels_like\":70.47,\"temp_min\":67.08,\"temp_max\":67.86,\"pressure\":1012,\"sea_level\":1012,\"grnd_level\":987,\"humidity\":83,\"temp_kf\":0.43},\"weather\":[{\"id\":804,\"main\":\"Clouds\",\"description\":\"overcast clouds\",\"icon\":\"04n\"}],\"clouds\":{\"all\":97},\"wind\":{\"speed\":2.89,\"deg\":140},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-22 03:00:00\"},{\"dt\":1592805600,\"main\":{\"temp\":66.29,\"feels_like\":68.05,\"temp_min\":65.98,\"temp_max\":66.29,\"pressure\":1012,\"sea_level\":1012,\"grnd_level\":987,\"humidity\":88,\"temp_kf\":0.17},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04n\"}],\"clouds\":{\"all\":58},\"wind\":{\"speed\":4.5,\"deg\":163},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-22 06:00:00\"},{\"dt\":1592816400,\"main\":{\"temp\":64.6,\"feels_like\":66.33,\"temp_min\":64.54,\"temp_max\":64.6,\"pressure\":1012,\"sea_level\":1012,\"grnd_level\":987,\"humidity\":89,\"temp_kf\":0.03},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":3},\"wind\":{\"speed\":3.6,\"deg\":225},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-22 09:00:00\"},{\"dt\":1592827200,\"main\":{\"temp\":67.24,\"feels_like\":69.31,\"temp_min\":67.24,\"temp_max\":67.24,\"pressure\":1012,\"sea_level\":1012,\"grnd_level\":987,\"humidity\":83,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":{\"all\":2},\"wind\":{\"speed\":3.44,\"deg\":203},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-22 12:00:00\"},{\"dt\":1592838000,\"main\":{\"temp\":76.86,\"feels_like\":79.3,\"temp_min\":76.86,\"temp_max\":76.86,\"pressure\":1012,\"sea_level\":1012,\"grnd_level\":987,\"humidity\":69,\"temp_kf\":0},\"weather\":[{\"id\":802,\"main\":\"Clouds\",\"description\":\"scattered clouds\",\"icon\":\"03d\"}],\"clouds\":{\"all\":47},\"wind\":{\"speed\":5.75,\"deg\":196},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-22 15:00:00\"},{\"dt\":1592848800,\"main\":{\"temp\":83.66,\"feels_like\":83.7,\"temp_min\":83.66,\"temp_max\":83.66,\"pressure\":1011,\"sea_level\":1011,\"grnd_level\":986,\"humidity\":54,\"temp_kf\":0},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04d\"}],\"clouds\":{\"all\":74},\"wind\":{\"speed\":9.51,\"deg\":209},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-22 18:00:00\"},{\"dt\":1592859600,\"main\":{\"temp\":85.95,\"feels_like\":85.77,\"temp_min\":85.95,\"temp_max\":85.95,\"pressure\":1008,\"sea_level\":1008,\"grnd_level\":984,\"humidity\":51,\"temp_kf\":0},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04d\"}],\"clouds\":{\"all\":83},\"wind\":{\"speed\":10.25,\"deg\":190},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-22 21:00:00\"},{\"dt\":1592870400,\"main\":{\"temp\":78.91,\"feels_like\":78.51,\"temp_min\":78.91,\"temp_max\":78.91,\"pressure\":1007,\"sea_level\":1007,\"grnd_level\":983,\"humidity\":68,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":92},\"wind\":{\"speed\":12.03,\"deg\":189},\"rain\":{\"3h\":2.63},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-23 00:00:00\"},{\"dt\":1592881200,\"main\":{\"temp\":75.51,\"feels_like\":76.44,\"temp_min\":75.51,\"temp_max\":75.51,\"pressure\":1007,\"sea_level\":1007,\"grnd_level\":982,\"humidity\":75,\"temp_kf\":0},\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate rain\",\"icon\":\"10n\"}],\"clouds\":{\"all\":100},\"wind\":{\"speed\":9.33,\"deg\":213},\"rain\":{\"3h\":4.24},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-23 03:00:00\"},{\"dt\":1592892000,\"main\":{\"temp\":72.23,\"feels_like\":71.31,\"temp_min\":72.23,\"temp_max\":72.23,\"pressure\":1005,\"sea_level\":1005,\"grnd_level\":980,\"humidity\":86,\"temp_kf\":0},\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate rain\",\"icon\":\"10n\"}],\"clouds\":{\"all\":100},\"wind\":{\"speed\":13.27,\"deg\":212},\"rain\":{\"3h\":5.66},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-23 06:00:00\"},{\"dt\":1592902800,\"main\":{\"temp\":69.62,\"feels_like\":71.13,\"temp_min\":69.62,\"temp_max\":69.62,\"pressure\":1004,\"sea_level\":1004,\"grnd_level\":979,\"humidity\":88,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10n\"}],\"clouds\":{\"all\":99},\"wind\":{\"speed\":7.4,\"deg\":226},\"rain\":{\"3h\":2.33},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-23 09:00:00\"},{\"dt\":1592913600,\"main\":{\"temp\":69.4,\"feels_like\":70.66,\"temp_min\":69.4,\"temp_max\":69.4,\"pressure\":1004,\"sea_level\":1004,\"grnd_level\":979,\"humidity\":91,\"temp_kf\":0},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04d\"}],\"clouds\":{\"all\":83},\"wind\":{\"speed\":8.46,\"deg\":248},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-23 12:00:00\"},{\"dt\":1592924400,\"main\":{\"temp\":72.18,\"feels_like\":73,\"temp_min\":72.18,\"temp_max\":72.18,\"pressure\":1006,\"sea_level\":1006,\"grnd_level\":981,\"humidity\":80,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":100},\"wind\":{\"speed\":8.43,\"deg\":274},\"rain\":{\"3h\":0.36},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-23 15:00:00\"},{\"dt\":1592935200,\"main\":{\"temp\":77.52,\"feels_like\":75.67,\"temp_min\":77.52,\"temp_max\":77.52,\"pressure\":1007,\"sea_level\":1007,\"grnd_level\":982,\"humidity\":65,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":84},\"wind\":{\"speed\":12.53,\"deg\":288},\"rain\":{\"3h\":1.17},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-23 18:00:00\"},{\"dt\":1592946000,\"main\":{\"temp\":78.57,\"feels_like\":75.13,\"temp_min\":78.57,\"temp_max\":78.57,\"pressure\":1006,\"sea_level\":1006,\"grnd_level\":982,\"humidity\":56,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":40},\"wind\":{\"speed\":12.95,\"deg\":295},\"rain\":{\"3h\":0.35},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-23 21:00:00\"},{\"dt\":1592956800,\"main\":{\"temp\":73.8,\"feels_like\":70.86,\"temp_min\":73.8,\"temp_max\":73.8,\"pressure\":1008,\"sea_level\":1008,\"grnd_level\":983,\"humidity\":60,\"temp_kf\":0},\"weather\":[{\"id\":802,\"main\":\"Clouds\",\"description\":\"scattered clouds\",\"icon\":\"03d\"}],\"clouds\":{\"all\":45},\"wind\":{\"speed\":10.38,\"deg\":301},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-24 00:00:00\"},{\"dt\":1592967600,\"main\":{\"temp\":68.4,\"feels_like\":65.5,\"temp_min\":68.4,\"temp_max\":68.4,\"pressure\":1009,\"sea_level\":1009,\"grnd_level\":984,\"humidity\":63,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":9},\"wind\":{\"speed\":8.08,\"deg\":297},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-24 03:00:00\"},{\"dt\":1592978400,\"main\":{\"temp\":65.43,\"feels_like\":64.33,\"temp_min\":65.43,\"temp_max\":65.43,\"pressure\":1009,\"sea_level\":1009,\"grnd_level\":984,\"humidity\":73,\"temp_kf\":0},\"weather\":[{\"id\":801,\"main\":\"Clouds\",\"description\":\"few clouds\",\"icon\":\"02n\"}],\"clouds\":{\"all\":20},\"wind\":{\"speed\":5.59,\"deg\":290},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-24 06:00:00\"},{\"dt\":1592989200,\"main\":{\"temp\":63.32,\"feels_like\":62.58,\"temp_min\":63.32,\"temp_max\":63.32,\"pressure\":1010,\"sea_level\":1010,\"grnd_level\":984,\"humidity\":78,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":4.83,\"deg\":257},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-24 09:00:00\"},{\"dt\":1593000000,\"main\":{\"temp\":63.99,\"feels_like\":62.55,\"temp_min\":63.99,\"temp_max\":63.99,\"pressure\":1011,\"sea_level\":1011,\"grnd_level\":986,\"humidity\":79,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":6.67,\"deg\":254},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-24 12:00:00\"},{\"dt\":1593010800,\"main\":{\"temp\":72.07,\"feels_like\":70,\"temp_min\":72.07,\"temp_max\":72.07,\"pressure\":1011,\"sea_level\":1011,\"grnd_level\":986,\"humidity\":60,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":7.85,\"deg\":264},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-24 15:00:00\"},{\"dt\":1593021600,\"main\":{\"temp\":76.42,\"feels_like\":72.7,\"temp_min\":76.42,\"temp_max\":76.42,\"pressure\":1011,\"sea_level\":1011,\"grnd_level\":986,\"humidity\":52,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":5},\"wind\":{\"speed\":10.83,\"deg\":260},\"rain\":{\"3h\":0.26},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-24 18:00:00\"},{\"dt\":1593032400,\"main\":{\"temp\":76.84,\"feels_like\":72.52,\"temp_min\":76.84,\"temp_max\":76.84,\"pressure\":1011,\"sea_level\":1011,\"grnd_level\":986,\"humidity\":51,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":4},\"wind\":{\"speed\":11.79,\"deg\":288},\"rain\":{\"3h\":0.38},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-24 21:00:00\"},{\"dt\":1593043200,\"main\":{\"temp\":73.04,\"feels_like\":71.4,\"temp_min\":73.04,\"temp_max\":73.04,\"pressure\":1012,\"sea_level\":1012,\"grnd_level\":987,\"humidity\":61,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":2},\"wind\":{\"speed\":7.92,\"deg\":322},\"rain\":{\"3h\":0.15},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-25 00:00:00\"},{\"dt\":1593054000,\"main\":{\"temp\":67.89,\"feels_like\":66.72,\"temp_min\":67.89,\"temp_max\":67.89,\"pressure\":1014,\"sea_level\":1014,\"grnd_level\":988,\"humidity\":64,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":6},\"wind\":{\"speed\":4.99,\"deg\":9},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-25 03:00:00\"},{\"dt\":1593064800,\"main\":{\"temp\":64.8,\"feels_like\":64.22,\"temp_min\":64.8,\"temp_max\":64.8,\"pressure\":1014,\"sea_level\":1014,\"grnd_level\":989,\"humidity\":67,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":3},\"wind\":{\"speed\":3,\"deg\":39},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-25 06:00:00\"},{\"dt\":1593075600,\"main\":{\"temp\":62.37,\"feels_like\":62.11,\"temp_min\":62.37,\"temp_max\":62.37,\"pressure\":1015,\"sea_level\":1015,\"grnd_level\":989,\"humidity\":72,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":2.21,\"deg\":187},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-25 09:00:00\"},{\"dt\":1593086400,\"main\":{\"temp\":64.45,\"feels_like\":64,\"temp_min\":64.45,\"temp_max\":64.45,\"pressure\":1016,\"sea_level\":1016,\"grnd_level\":991,\"humidity\":73,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":{\"all\":1},\"wind\":{\"speed\":3.89,\"deg\":213},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-25 12:00:00\"},{\"dt\":1593097200,\"main\":{\"temp\":73.27,\"feels_like\":70.81,\"temp_min\":73.27,\"temp_max\":73.27,\"pressure\":1017,\"sea_level\":1017,\"grnd_level\":992,\"humidity\":54,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":7.49,\"deg\":244},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-25 15:00:00\"},{\"dt\":1593108000,\"main\":{\"temp\":78.03,\"feels_like\":75.16,\"temp_min\":78.03,\"temp_max\":78.03,\"pressure\":1016,\"sea_level\":1016,\"grnd_level\":991,\"humidity\":51,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":9.86,\"deg\":231},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-25 18:00:00\"},{\"dt\":1593118800,\"main\":{\"temp\":78.58,\"feels_like\":76.01,\"temp_min\":78.58,\"temp_max\":78.58,\"pressure\":1015,\"sea_level\":1015,\"grnd_level\":990,\"humidity\":51,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":23},\"wind\":{\"speed\":9.69,\"deg\":249},\"rain\":{\"3h\":0.29},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-25 21:00:00\"},{\"dt\":1593129600,\"main\":{\"temp\":75.69,\"feels_like\":75.15,\"temp_min\":75.69,\"temp_max\":75.69,\"pressure\":1014,\"sea_level\":1014,\"grnd_level\":990,\"humidity\":60,\"temp_kf\":0},\"weather\":[{\"id\":802,\"main\":\"Clouds\",\"description\":\"scattered clouds\",\"icon\":\"03d\"}],\"clouds\":{\"all\":26},\"wind\":{\"speed\":7.31,\"deg\":248},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-26 00:00:00\"},{\"dt\":1593140400,\"main\":{\"temp\":70.63,\"feels_like\":71.22,\"temp_min\":70.63,\"temp_max\":70.63,\"pressure\":1016,\"sea_level\":1016,\"grnd_level\":991,\"humidity\":72,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":5.55,\"deg\":218},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-26 03:00:00\"},{\"dt\":1593151200,\"main\":{\"temp\":67.17,\"feels_like\":67.62,\"temp_min\":67.17,\"temp_max\":67.17,\"pressure\":1016,\"sea_level\":1016,\"grnd_level\":990,\"humidity\":81,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":1},\"wind\":{\"speed\":5.79,\"deg\":210},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-26 06:00:00\"},{\"dt\":1593162000,\"main\":{\"temp\":67.75,\"feels_like\":68.74,\"temp_min\":67.75,\"temp_max\":67.75,\"pressure\":1015,\"sea_level\":1015,\"grnd_level\":990,\"humidity\":84,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10n\"}],\"clouds\":{\"all\":47},\"wind\":{\"speed\":5.95,\"deg\":200},\"rain\":{\"3h\":0.34},\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2020-06-26 09:00:00\"},{\"dt\":1593172800,\"main\":{\"temp\":68.95,\"feels_like\":69.39,\"temp_min\":68.95,\"temp_max\":68.95,\"pressure\":1016,\"sea_level\":1016,\"grnd_level\":991,\"humidity\":86,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":37},\"wind\":{\"speed\":8.3,\"deg\":208},\"rain\":{\"3h\":0.47},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-26 12:00:00\"},{\"dt\":1593183600,\"main\":{\"temp\":76.86,\"feels_like\":78.01,\"temp_min\":76.86,\"temp_max\":76.86,\"pressure\":1016,\"sea_level\":1016,\"grnd_level\":991,\"humidity\":76,\"temp_kf\":0},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04d\"}],\"clouds\":{\"all\":61},\"wind\":{\"speed\":10.38,\"deg\":214},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-26 15:00:00\"},{\"dt\":1593194400,\"main\":{\"temp\":85.28,\"feels_like\":85.6,\"temp_min\":85.28,\"temp_max\":85.28,\"pressure\":1014,\"sea_level\":1014,\"grnd_level\":990,\"humidity\":57,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":67},\"wind\":{\"speed\":11.5,\"deg\":226},\"rain\":{\"3h\":2.98},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-26 18:00:00\"},{\"dt\":1593205200,\"main\":{\"temp\":85.41,\"feels_like\":85.37,\"temp_min\":85.41,\"temp_max\":85.41,\"pressure\":1013,\"sea_level\":1013,\"grnd_level\":989,\"humidity\":59,\"temp_kf\":0},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"clouds\":{\"all\":71},\"wind\":{\"speed\":13.09,\"deg\":222},\"rain\":{\"3h\":2.42},\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2020-06-26 21:00:00\"}],\"city\":{\"id\":4259418,\"name\":\"Indianapolis\",\"coord\":{\"lat\":39.7684,\"lon\":-86.158},\"country\":\"US\",\"population\":829718,\"timezone\":-14400,\"sunrise\":1592734610,\"sunset\":1592788571}}".data(using: .utf8)
		let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
		self.webServices.session = mockURLSession
		self.webServices.location = location
		let forecastExpecation = expectation(description: "Current Forecast")
		var forecastResponse: FiveDayWeather?
		
		self.webServices.getForecastTemperature { (forecastWeather, error) in
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
		self.webServices.session = mockURLSession
		self.webServices.location = location
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		self.webServices.getCurrentTemperature { (currentWeather, error) in
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
		self.webServices.session = mockURLSession
		self.webServices.location = location
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		self.webServices.getForecastTemperature{ (forecastWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetCurrentTempWhenEmmptyDataReturnsError() {
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
		self.webServices.session = mockURLSession
		self.webServices.location = location
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		self.webServices.getCurrentTemperature { (currentWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetForecastTempWhenEmptyDataReturnsError() {
		let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
		self.webServices.session = mockURLSession
		self.webServices.location = location
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		self.webServices.getForecastTemperature{ (forecastWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetCurrentTempInvalidJSONReturnsError() {
		let jsonData = "[{\"t\"}]".data(using: .utf8)
		let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
		self.webServices.session = mockURLSession
		self.webServices.location = location
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		self.webServices.getCurrentTemperature { (currentWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}
	
	func testGetForecastTempINvalidJSONReturnsError() {
		let jsonData = "[{\"t\"}]".data(using: .utf8)
		let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
		self.webServices.session = mockURLSession
		self.webServices.location = location
		let errorExpectation = expectation(description: "error")
		var errorResponse: Error?
		
		self.webServices.getForecastTemperature{ (forecastWeather, error) in
			errorResponse = error
			errorExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 1) { (error) in
			XCTAssertNotNil(errorResponse)
		}
	}

}
