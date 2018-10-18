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
}

class Model {
	let weather: [Weather]
	
	var min: Double
	var max: Double
	
	init(dataPoints: [DataPoint]) {
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
