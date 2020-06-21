//
//  MockURLSession.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/21/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation
class MockURLSession: URLSession {
	var cachedUrl: URL?
	private let mockTask: MockTask
	init(data: Data?, urlResponse: URLResponse?, error: Error?) {
		mockTask = MockTask(data: data, urlResponse: urlResponse, error: error)
	}
	
	override func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		self.cachedUrl = url
		let configuration = URLSessionConfiguration.default
		configuration.isDiscretionary = true
		configuration.timeoutIntervalForRequest = 30
		mockTask.completionHandler = completionHandler
		return mockTask
	}
}
