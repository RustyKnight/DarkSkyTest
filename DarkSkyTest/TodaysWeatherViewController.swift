//
//  TodaysWeatherViewController.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 19/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit

class TodaysWeatherViewController: UIViewController {
	
	@IBOutlet var stackViews: [UIStackView]!
	
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var currentTempLabel: UILabel!
	
	@IBOutlet weak var weatherImageView: UIImageView!
	
	@IBOutlet weak var lowTempLabel: UILabel!
	@IBOutlet weak var highTempLabel: UILabel!
	
	@IBOutlet weak var windDirectionImageView: UIImageView!
	@IBOutlet weak var windSpeedLabel: UILabel!
	@IBOutlet weak var windDirectionLabel: UILabel!

	@IBOutlet weak var rainImageView: UIImageView!
	@IBOutlet weak var rainLabel: UILabel!

	@IBOutlet weak var uvImageView: UIImageView!
	@IBOutlet weak var uvLabel: UILabel!

	@IBOutlet weak var visibilityImageView: UIImageView!
	@IBOutlet weak var visibilityLabel: UILabel!
	
	var measurementFormatter: MeasurementFormatter = {
		let formatter = MeasurementFormatter()
		formatter.numberFormatter.maximumFractionDigits = 2
		return formatter
	}()
	
	var percentageFormatter: NumberFormatter = {
		let nf = NumberFormatter()
		nf.numberStyle = .percent
		return nf
	}()
	
	var model: Model? {
		didSet {
			configure()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		weatherImageView.image = WeatherStyleKit.imageOfClearDay
		
		windDirectionImageView.image = WeatherStyleKit.imageOfWindDirection()
		rainImageView.image = WeatherStyleKit.imageOfRain
		uvImageView.image = WeatherStyleKit.imageOfClearDay
		visibilityImageView.image = WeatherStyleKit.imageOfVisibility
		
		configure()
	}
	
	func configure() {
		defer {
			for stackView in stackViews {
				stackView.invalidateIntrinsicContentSize()
				stackView.setNeedsLayout()
			}
			
			view.setNeedsLayout()
			view.layoutIfNeeded()
		}
		
		guard let model = model else {
			lowTempLabel.text = "---"
			highTempLabel.text = "---"
			windSpeedLabel.text = "---"
			windDirectionLabel.text = "---"
			rainLabel.text = "---"
			uvLabel.text = "---"
			visibilityLabel.text = "---"
			weatherImageView.image = WeatherStyleKit.imageOfClearDay
			return
		}
		switch model.current.icon {
		case "clear-day": weatherImageView.image = WeatherStyleKit.imageOfClearDay
		case "clear-night": weatherImageView.image = WeatherStyleKit.imageOfClearNight
		case "rain": weatherImageView.image = WeatherStyleKit.imageOfRaining
		case "snow": weatherImageView.image = WeatherStyleKit.imageOfSnowing
		case "sleet": weatherImageView.image = WeatherStyleKit.imageOfSleet
		case "wind": weatherImageView.image = WeatherStyleKit.imageOfWind
		case "fog": weatherImageView.image = WeatherStyleKit.imageOfFog
		case "cloudy": fallthrough
		case "partly-cloudy-day": weatherImageView.image = WeatherStyleKit.imageOfCloudyDay
		case "partly-cloudy-night": weatherImageView.image = WeatherStyleKit.imageOfCloudyNight
		default: weatherImageView.image = WeatherStyleKit.imageOfClearDay
		}
		
		descriptionLabel.text = model.current.description
		let temp = Measurement(value: model.current.forecastTempature, unit: UnitTemperature.celsius)
		currentTempLabel.text = measurementFormatter.string(from: temp)

		configureTemp(model)
		configureWind(model)
		configureRain(model)
		configureUV(model)
		configureVisibility(model)
	}

	func configureVisibility(_ model: Model) {
		let visibility = Measurement(value: model.today.visibility, unit: UnitLength.kilometers)
		visibilityLabel.text = measurementFormatter.string(from: visibility)
	}

	func configureUV(_ model: Model) {
		uvLabel.text = String(model.today.uvIndex)
	}

	func configureRain(_ model: Model) {
		rainLabel.text = percentageFormatter.string(for: model.today.chanceOfRain)
	}

	func configureTemp(_ model: Model) {
		let low = Measurement(value: model.today.min, unit: UnitTemperature.celsius)
		let high = Measurement(value: model.today.max, unit: UnitTemperature.celsius)
		
		lowTempLabel.text = measurementFormatter.string(from: low)
		highTempLabel.text = measurementFormatter.string(from: high)
	}
	
	func configureWind(_ model: Model) {
		let speedMeasure = Measurement(value: model.today.windSpeed, unit: UnitSpeed.kilometersPerHour)
		//let guestMeasure = Measurement(value: model.current.windGust, unit: UnitSpeed.kilometersPerHour)
		let windDirection = model.today.windDirection
		let direction = WindDirection.direction(at: Double(windDirection))

		windDirectionImageView.image = WeatherStyleKit.imageOfWindDirection(direction: CGFloat(windDirection))
		
		windSpeedLabel.text = measurementFormatter.string(from: speedMeasure)
		windDirectionLabel.text = direction.description
	}
	
}
