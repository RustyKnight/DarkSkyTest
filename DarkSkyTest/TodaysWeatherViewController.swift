//
//  TodaysWeatherViewController.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 19/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit

class TodaysWeatherViewController: UIViewController {
	
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
	
	var animator: LinearAnimator?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		weatherImageView.image = WeatherStyleKit.imageOfClearDayAnimated()
		
		windDirectionImageView.image = WeatherStyleKit.imageOfWindDirection()
		rainImageView.image = WeatherStyleKit.imageOfRainColored
		uvImageView.image = WeatherStyleKit.imageOfUVColored
		visibilityImageView.image = WeatherStyleKit.imageOfVisibilityColored
		
		configure()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		animator = LinearAnimator(ticker: { (animator) in
			self.updateIcon()
		})
		animator?.start()
	}
	
	var anchorTime: Date?
	var duration: TimeInterval = 5.0
	
	func updateIcon() {
		guard let model = model else {
			windDirectionImageView.image = WeatherStyleKit.imageOfWindDirection()
			return
		}
		if anchorTime == nil {
			anchorTime = Date()
		}
		var runningTime = Date().timeIntervalSince(anchorTime!)
		if runningTime >= duration {
			anchorTime = Date()
			runningTime = duration
		}
		let progress = runningTime / duration
		
		switch model.current.icon {
		case "clear-day":
			weatherImageView.image = WeatherStyleKit.imageOfClearDayAnimated(animationProgress: CGFloat(progress))
		case "clear-night":
			weatherImageView.image = WeatherStyleKit.imageOfClearNightAnimated(animationProgress: CGFloat(progress))
		case "rain":
			weatherImageView.image = WeatherStyleKit.imageOfRainingAnimated
		case "snow":
			weatherImageView.image = WeatherStyleKit.imageOfSnowingAnimated
		case "sleet":
			weatherImageView.image = WeatherStyleKit.imageOfSleetAnimated
		case "wind":
			weatherImageView.image = WeatherStyleKit.imageOfWindyAnimated(animationProgress: CGFloat(progress))
		case "fog":
			weatherImageView.image = WeatherStyleKit.imageOfFogAnimated(animationProgress: CGFloat(progress))
		case "cloudy": fallthrough
		case "partly-cloudy-day": weatherImageView.image = WeatherStyleKit.imageOfCloudyDayAnimated(animationProgress: CGFloat(progress))
		case "partly-cloudy-night": weatherImageView.image = WeatherStyleKit.imageOfCloudyNightAnimated(animationProgress: CGFloat(progress))
		default:
			weatherImageView.image = WeatherStyleKit.imageOfClearDayAnimated(animationProgress: CGFloat(progress))
		}
	}
	
	func configure() {
		defer {
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
			uvLabel.backgroundColor = UIColor.clear
			visibilityLabel.text = "---"
			weatherImageView.image = WeatherStyleKit.imageOfClearDayAnimated()
			return
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
		
		switch model.today.uvIndex {
		case 0..<3:
			uvLabel.text = "Low"
		case 3..<6:
			uvLabel.text = "Moderate"
		case 6..<8:
			uvLabel.text = "High"
		case 8..<11:
			uvLabel.text = "Very high"
		default:
			uvLabel.text = "Very extreme"
		}
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
