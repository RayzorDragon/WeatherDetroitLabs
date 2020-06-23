//
//  ForecastTableViewCell.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/22/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

	static let identifier = "ForecastCell"
	var forecast: ForecastWeather? {
		didSet {
			self.updateDisplay()
		}
	}
	
	@IBOutlet weak var dateTimeLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var iconView: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	override func prepareForReuse() {
		dateTimeLabel.text = nil
		temperatureLabel.text = nil
		iconView.image = nil
	}

	private func updateDisplay() {
		DispatchQueue.main.async {
			self.dateTimeLabel.text = self.forecast?.dt_txt
			if let temp = self.forecast?.main.temp {
				self.temperatureLabel.text = TemperatureHandler.temperatureString(temp: temp, scale: .fahrenheit)
			}
			if let urlString = self.forecast?.weather.first?.iconURLString {
				self.iconView.downloaded(from: urlString)
			}
		}
	}
}
