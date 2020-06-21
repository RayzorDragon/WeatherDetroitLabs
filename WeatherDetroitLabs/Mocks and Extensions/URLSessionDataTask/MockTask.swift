//
//  MockTask.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/21/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation
class MockTask: URLSessionDataTask {
  private let data: Data?
  private let urlResponse: URLResponse?
  private let errorInternal: Error?

  var completionHandler: ((Data?, URLResponse?, Error?) -> Void)
  init(data: Data?, urlResponse: URLResponse?, error: Error?) {
    self.data = data
    self.urlResponse = urlResponse
    self.errorInternal = error
	
	let emptyCompletion: ((Data?, URLResponse?, Error?) -> Void) = { (_, _, _) in
		print("empty block executed")
		return
	}
	
	self.completionHandler = emptyCompletion
	super.init()
  }
  override func resume() {
    DispatchQueue.main.async {
		self.completionHandler(self.data, self.urlResponse, self.errorInternal)
    }
  }
}
