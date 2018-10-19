//
//  ViewController.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 17/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit
//import Charts
import SwiftSky
import SwiftDate

class ViewController: UIViewController {

//	@IBOutlet weak var chartView: LineChartView!
	
	@IBOutlet weak var weatherGraphViewNib: XibView!
	var weatherGraphView: WeatherGraphView {
		return weatherGraphViewNib.contentView as! WeatherGraphView
	}
	
	var todaysWeatherViewController: TodaysWeatherViewController!
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "Current" {
			guard let vc = segue.destination as? TodaysWeatherViewController else {
				return
			}
			todaysWeatherViewController = vc
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// bbeb79d6e86467de1c0e7875274b8cab
		
		SwiftSky.secret = "bbeb79d6e86467de1c0e7875274b8cab"
		SwiftSky.hourAmount = .hundredSixtyEight
		SwiftSky.language = .english
		SwiftSky.locale = Locale.current
		SwiftSky.locale = .autoupdatingCurrent
		
		SwiftSky.units.temperature = .celsius
		SwiftSky.units.distance = .kilometer
		SwiftSky.units.speed = .kilometerPerHour
		SwiftSky.units.pressure = .millibar
		SwiftSky.units.precipitation = .millimeter
		SwiftSky.units.accumulation = .centimeter
		
		SwiftSky.hourAmount = .hundredSixtyEight

		//https://www.google.com/maps/place/Beam+Communications/@-37.920416,145.1466803,17z/data=!3m1!4b1!4m5!3m4!1s0x6ad6153a83379e53:0xe26e5d3612a942eb!8m2!3d-37.920416!4d145.148869

		SwiftSky.get([.current, .hours, .alerts, .days], at: "-37.920416,145.1466803") { (result) in
			switch result {
			case .success(let forecast):
				
				self.load(current: forecast.current!,
									today: forecast.days!.points[0],
									forecasts: self.filter(forecast))
			case .failure(let error):
				print(error)
			}
		}


//
//		var forcast = [ChartDataEntry]()
//		var actual = [ChartDataEntry]()
//		var x = 0.0
//		for num in 0..<100 {
////			let x = Double.random(in: 0..<10)
//			let y = Double.random(in: 10..<20)
//			x += 10
//			let value = ChartDataEntry(x: x, y: y)
//			forcast.append(value)
//			actual.append(ChartDataEntry(x: x, y: y - 2))
//		}
//
//		let forcastDataSet = LineChartDataSet(values: forcast, label: nil)
//		forcastDataSet.colors = [NSUIColor.blue]
//
//		forcastDataSet.setDrawHighlightIndicators(false)
//		forcastDataSet.highlightEnabled = false
//		forcastDataSet.circleRadius = 4
//		forcastDataSet.drawCircleHoleEnabled = false
//		forcastDataSet.lineCapType = .round
//		forcastDataSet.mode = .cubicBezier
//
//		let colorTop =  UIColor(red: 1, green: 0, blue: 0, alpha: 0.5).cgColor
//		let colorBottom = UIColor(red: 1, green: 1, blue: 0, alpha: 0.5).cgColor
//
//		let gradientColors = [colorTop, colorBottom] as CFArray
//		let colorLocations:[CGFloat] = [0.0, 1.0]
//		let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
//																	 colors: gradientColors,
//																	 locations: colorLocations) // Gradient Object
//		forcastDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
//		forcastDataSet.drawFilledEnabled = true
//
//		let actualDataSet = LineChartDataSet(values: actual, label: nil)
//		actualDataSet.colors = [NSUIColor.red]
//		actualDataSet.fillAlpha = 0.0
//		actualDataSet.lineDashLengths = [5, 5]
//
//		actualDataSet.setDrawHighlightIndicators(false)
//		actualDataSet.highlightEnabled = false
//		actualDataSet.drawCirclesEnabled = false
//		actualDataSet.drawCircleHoleEnabled = false
//		actualDataSet.lineCapType = .round
//		actualDataSet.mode = .cubicBezier
//		actualDataSet.drawValuesEnabled = false
////		actualDataSet.dash
//
//		let data = LineChartData()
//		data.addDataSet(forcastDataSet)
//		data.addDataSet(actualDataSet)
//		chartView.data = data
//		chartView.legend.enabled = false
//		chartView.backgroundColor = UIColor.lightGray
//
//		chartView.drawGridBackgroundEnabled = false
//
//		chartView.xAxis.drawLabelsEnabled = false
//		chartView.xAxis.drawAxisLineEnabled = false
//		chartView.xAxis.drawGridLinesEnabled = false
//
//		chartView.leftAxis.drawGridLinesEnabled = false
//		chartView.leftAxis.drawAxisLineEnabled = false
//		chartView.leftAxis.drawLabelsEnabled = false
//		chartView.leftAxis.drawZeroLineEnabled = false
//		chartView.leftAxis.drawTopYLabelEntryEnabled = false
//		chartView.leftAxis.drawBottomYLabelEntryEnabled = false
//
//		chartView.rightAxis.drawGridLinesEnabled = false
//		chartView.rightAxis.drawAxisLineEnabled = false
//		chartView.rightAxis.drawLabelsEnabled = false
//		chartView.rightAxis.drawZeroLineEnabled = false
//		chartView.rightAxis.drawTopYLabelEntryEnabled = false
//		chartView.rightAxis.drawBottomYLabelEntryEnabled = false
//
//		chartView.zoom(scaleX: 4.0, scaleY: 1.0, x: 0, y: 0)
//		chartView.doubleTapToZoomEnabled = false
//		chartView.pinchZoomEnabled = false
//		chartView.setScaleEnabled(false)
	}
	
	func load(current: DataPoint, today: DataPoint, forecasts dataSet: [DataPoint]) {
		let model = Model(current: current, today: today, dataPoints: dataSet)
		print("Load model")
		weatherGraphView.model = model
		todaysWeatherViewController.model = model
	}

	func filter(_ forecast: Forecast) -> [DataPoint] {
		guard let hours = forecast.hours else {
			print("No hourly data")
			return []
		}
		
		let lastHour = hours.points.first!.time

		var forecasts: [DataPoint] = []
		var endDate = lastHour + 14.hours
		var nextDate = lastHour
		
		var index = 0
		while nextDate.isBeforeDate(endDate, granularity: .hour) && index < hours.points.count {
			if hours.points[index].time == nextDate {
				forecasts.append(hours.points[index])
				nextDate = nextDate + 2.hours
			}
			index += 1
		}

		nextDate = forecasts.last!.time + 6.hours
		endDate = nextDate + 30.hours

		while nextDate.isBeforeDate(endDate, granularity: .hour) && index < hours.points.count {
			if hours.points[index].time == nextDate {
				forecasts.append(hours.points[index])
				nextDate = nextDate + 6.hours
			}
			index += 1
		}
		
		return forecasts
	}

}

