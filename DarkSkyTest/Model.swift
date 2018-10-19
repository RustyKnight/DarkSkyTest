//
//  Model.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 18/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import Foundation
import SwiftSky

struct Weather {
	fileprivate let dataPoint: DataPoint
	
	var description: String {
		return dataPoint.summary!
	}
	
	var date: Date {
		return dataPoint.time
	}
	
	var apparentTempature: Double {
		return dataPoint.temperature!.apparent!.current!.value
	}
	
	var forecastTempature: Double {
		return dataPoint.temperature!.current!.value
	}
	
	var chanceOfRain: Double {
		return Double(dataPoint.precipitation!.probability!.value) / 100.0
	}
	
	var windSpeed: Double {
		return dataPoint.wind!.speed!.value
	}
	
	var windGust: Double {
		return dataPoint.wind!.gust!.value
	}
	
	var windDirection: Int {
		return dataPoint.wind!.bearing!.degrees
	}
	
	var uvIndex: Int {
		return dataPoint.uvIndex!
	}
	
	var visibility: Double {
		return dataPoint.visibility!.value
	}
	
	var icon: String {
		return dataPoint.icon!
	}
	
	var min: Double {
		return dataPoint.temperature!.min!.value
	}

	var max: Double {
		return dataPoint.temperature!.max!.value
	}
}

class Model {
	let weather: [Weather]
	let current: Weather
	let today: Weather
	
	let min: Double
	let max: Double
	
	init(current: DataPoint, today: DataPoint, dataPoints: [DataPoint]) {
		self.current = Weather(dataPoint: current)
		self.today = Weather(dataPoint: today)
		
		var items: [Weather] = []
		for dp in dataPoints {
			items.append(Weather(dataPoint: dp))
		}
		weather = items
		min = weather.min { (lhs, rhs) -> Bool in
			return lhs.forecastTempature < rhs.forecastTempature
		}?.forecastTempature ?? 0
		max = weather.min { (lhs, rhs) -> Bool in
			return lhs.forecastTempature > rhs.forecastTempature
		}?.forecastTempature ?? 0
	}
}
