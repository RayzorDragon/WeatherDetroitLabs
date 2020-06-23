//
//  CurrentTempViewController.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/20/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import UIKit

class CurrentTempViewController: UIViewController {

	@IBOutlet weak var temperatureLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		NotificationCenter.default.addObserver(self, selector: #selector(currentWeatherUpdate), name: Constants.currentNotification.name, object: nil)
		currentWeatherUpdate()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc private func currentWeatherUpdate() {
		if let currentWeather = DataStore.sharedInstance.currentWeather {
				updateView(with: currentWeather)
		} else {
			displayError()
		}
	}
	
	private func updateView(with currentWeather:CurrentWeather) {
		// All updates should always be on the main thread
		DispatchQueue.main.async {
			let tempString = TemperatureHandler.temperatureString(temp: currentWeather.main.temp, scale: .fahrenheit)
			self.temperatureLabel.text = tempString
		}
	}
	
	private func displayError() {
		DispatchQueue.main.async {
			self.temperatureLabel.text = Constants.noGeoServiceWarning
		}
	}


}

