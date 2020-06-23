//
//  AppDelegate.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	let webService = WebServices(session: URLSession.shared, location: CurrentLocation())

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		loadAllData()
		return true
	}
	
	private func loadAllData() {
		webService.getCurrentTemperature { (currentWeather, error) in
			DataStore.sharedInstance.updateCurrent(update: currentWeather)
		}
		webService.getForecastTemperature { (fiveDayWeather, error) in
			DataStore.sharedInstance.updateForecast(update: fiveDayWeather)
		}
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

