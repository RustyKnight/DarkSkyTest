//
//  HeaderView.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 18/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit

enum WindDirection: Double, CustomStringConvertible {
	case north = 0
	case northNorthEast = 22.5
	case northEast = 45
	case eastNorthEast = 67.5
	case east = 90
	case eastSouthEast = 112.5
	case southEast = 135
	case southSouthEast = 157.5
	case south = 180
	case southSouthWest = 202.5
	case southWest = 225
	case westSouthWest = 247.5
	case west = 270
	case westNorthWest = 292.5
	case northWest = 315
	case northNorthWest = 337.5
	
	static func direction(at: Double) -> WindDirection {
		let values: [WindDirection] = [
			.north, .northNorthEast, .northEast,
			.eastNorthEast, .east, .eastSouthEast,
			.southEast, .southSouthEast, .south,
			.southSouthWest, .southWest, .westSouthWest,
			.west, .westNorthWest, .northWest,
			.northNorthWest
		]
		
		let closest = values.min { (lhs, rhs) -> Bool in
			return abs(lhs.rawValue - at) < abs(rhs.rawValue - at)
		}
		
		return closest ?? .north
	}
	
	var description: String {
		switch self {
		case .north: return "N"
		case .east: return "E"
		case .west: return "W"
		case .south: return "S"

		case .northEast: return "NE"
		case .southEast: return "SE"
		case .southWest: return "SW"
		case .northWest: return "NW"
			
		case .northNorthEast: return "NNE"
		case .eastNorthEast: return "ENE"
		case .eastSouthEast: return "ESE"
		case .southSouthEast: return "SSE"
		case .westSouthWest: return "WSW"
		case .southSouthWest: return "SSW"
		case .westNorthWest: return "WNW"
		case .northNorthWest: return "NWW"
		}
	}
}

@IBDesignable
class HeaderView: UIView {
	
	@IBOutlet weak var rainProbabilityLabel: UILabel!
	@IBOutlet weak var rainImageView: UIImageView!

	@IBOutlet weak var uvLabel: UILabel!
	@IBOutlet weak var uvImageView: UIImageView!

	@IBOutlet weak var visibilityLabel: UILabel!
	@IBOutlet weak var visibilityImageView: UIImageView!

	@IBOutlet weak var dateLabel: UILabel!
	
	@IBOutlet weak var windSpeedLabel: UILabel!
	@IBOutlet weak var windGustSpeedLabel: UILabel!
	
	@IBOutlet weak var windDirectionLabel: UILabel!
	@IBOutlet weak var windDirectionImageView: UIImageView!
	
	@IBOutlet weak var weatherImageView: UIImageView!
	
	var dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEE hh:mm a"
		
		return formatter
	}()
	
	var weather: Weather? {
		didSet {
			configure()
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUp()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setUp()
	}
	
	func setUp() {
		rainImageView.image = WeatherStyleKit.imageOfRain
		uvImageView.image = WeatherStyleKit.imageOfClearDay
		visibilityImageView.image = WeatherStyleKit.imageOfVisibility
		weatherImageView.image = WeatherStyleKit.imageOfClearDay
		configure()
	}
	
	func configure() {
		defer {
			setNeedsLayout()
		}

		guard let weather = weather else {
			windDirectionImageView.image = WeatherStyleKit.imageOfWindDirection()
			
			windSpeedLabel.text = "---"
			windGustSpeedLabel.text = "---"
			windDirectionLabel.text = "---"
			dateLabel.text = "---"
			
			rainProbabilityLabel.text = "---"
			
			return
		}
		
		dateLabel.text = dateFormatter.string(from: weather.date)
		
		windDirectionImageView.image = WeatherStyleKit.imageOfWindDirection(direction: CGFloat(weather.windDirection))
		
		let speed = weather.windSpeed
		let guest = weather.windGust
		
		let formatter = MeasurementFormatter()
		formatter.numberFormatter.maximumFractionDigits = 2
		
		let speedMeasure = Measurement(value: speed, unit: UnitSpeed.kilometersPerHour)
		let guestMeasure = Measurement(value: guest, unit: UnitSpeed.kilometersPerHour)
		
		windSpeedLabel.text = formatter.string(from: speedMeasure)
		windGustSpeedLabel.text = formatter.string(from: guestMeasure)
		
		let direction = WindDirection.direction(at: Double(weather.windDirection))
		
		windDirectionLabel.text = direction.description
		
		uvLabel.text = String(weather.uvIndex)
		
		let visibility = Measurement(value: weather.visibility, unit: UnitLength.kilometers)
		visibilityLabel.text = formatter.string(from: visibility)
		
		let probability = weather.chanceOfRain

		let nf = NumberFormatter()
		nf.numberStyle = .percent
		
		rainImageView.image = WeatherStyleKit.imageOfRain
		rainProbabilityLabel.text = nf.string(for: probability)
		
		switch weather.icon {
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
	}
	
}
