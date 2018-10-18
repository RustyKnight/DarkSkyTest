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

	@IBOutlet weak var windImageView: UIImageView!
	
	@IBOutlet weak var windSpeedLabel: UILabel!
	@IBOutlet weak var windGustSpeedLabel: UILabel!
	
	@IBOutlet weak var windDirectionLabel: UILabel!
	@IBOutlet weak var windDirectionImageView: UIImageView!
	
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
		windImageView.image = WeatherStyleKit.imageOfWind
		configure()
	}
	
	func configure() {
		guard let weather = weather else {
			windDirectionImageView.image = WeatherStyleKit.imageOfWindDirection()
			
			windSpeedLabel.text = "100 kph"
			windGustSpeedLabel.text = "100 kph"
			windDirectionLabel.text = "NNE"
			return
		}
		
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

	}
	
}
