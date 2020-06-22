//
//  Network.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import Foundation

class Network {
	var session: URLSession
	init(session: URLSession = URLSession.shared) {
		self.session = session
	}
	
	// genertic and typable data loader
	func loadDataFromWeb<T: Decodable>(url: URL, type: T.Type, completionHandler: @escaping (T?, Error?) -> Void) {
		
		session.dataTask(with: url) { (data, response, error) in
			let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
			
			guard error == nil else {
				completionHandler(nil, error)
				return
			}
			
			if statusCode != 200 {
				completionHandler(nil, NetworkError.requestError)
				return
			}
			
			guard let data = data else {
				completionHandler(nil, NetworkError.noData)
				return
			}
			
			do {
				let typedObject: T? = try JSONDecoder().decode(T.self, from: data)
				completionHandler(typedObject, nil)
			} catch {
				completionHandler(nil, NetworkError.parseError)
			}
			
			
		}.resume()
		
	}
}
