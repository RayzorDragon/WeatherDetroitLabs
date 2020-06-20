//
//  NetworkError.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case invalidURL
	case parseError
	case requestError
}
