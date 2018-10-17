//
//  ViewController.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 17/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

	@IBOutlet weak var chartView: LineChartView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var forcast = [ChartDataEntry]()
		var actual = [ChartDataEntry]()
		var x = 0.0
		for num in 0..<100 {
//			let x = Double.random(in: 0..<10)
			let y = Double.random(in: 10..<20)
			x += 10
			let value = ChartDataEntry(x: x, y: y)
			forcast.append(value)
			actual.append(ChartDataEntry(x: x, y: y - 2))
		}
		
		let forcastDataSet = LineChartDataSet(values: forcast, label: nil)
		forcastDataSet.colors = [NSUIColor.blue]
		
		forcastDataSet.setDrawHighlightIndicators(false)
		forcastDataSet.highlightEnabled = false
		forcastDataSet.circleRadius = 4
		forcastDataSet.drawCircleHoleEnabled = false
		forcastDataSet.lineCapType = .round
		forcastDataSet.mode = .cubicBezier

		let colorTop =  UIColor(red: 1, green: 0, blue: 0, alpha: 0.5).cgColor
		let colorBottom = UIColor(red: 1, green: 1, blue: 0, alpha: 0.5).cgColor
		
		let gradientColors = [colorTop, colorBottom] as CFArray
		let colorLocations:[CGFloat] = [0.0, 1.0]
		let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
																	 colors: gradientColors,
																	 locations: colorLocations) // Gradient Object
		forcastDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
		forcastDataSet.drawFilledEnabled = true
		
		let actualDataSet = LineChartDataSet(values: actual, label: nil)
		actualDataSet.colors = [NSUIColor.red]
		actualDataSet.fillAlpha = 0.0
		actualDataSet.lineDashLengths = [5, 5]
		
		actualDataSet.setDrawHighlightIndicators(false)
		actualDataSet.highlightEnabled = false
		actualDataSet.drawCirclesEnabled = false
		actualDataSet.drawCircleHoleEnabled = false
		actualDataSet.lineCapType = .round
		actualDataSet.mode = .cubicBezier
		actualDataSet.drawValuesEnabled = false
//		actualDataSet.dash

		let data = LineChartData()
		data.addDataSet(forcastDataSet)
		data.addDataSet(actualDataSet)
		chartView.data = data
		chartView.legend.enabled = false
		chartView.backgroundColor = UIColor.lightGray
		
		chartView.drawGridBackgroundEnabled = false
		
		chartView.xAxis.drawLabelsEnabled = false
		chartView.xAxis.drawAxisLineEnabled = false
		chartView.xAxis.drawGridLinesEnabled = false
		
		chartView.leftAxis.drawGridLinesEnabled = false
		chartView.leftAxis.drawAxisLineEnabled = false
		chartView.leftAxis.drawLabelsEnabled = false
		chartView.leftAxis.drawZeroLineEnabled = false
		chartView.leftAxis.drawTopYLabelEntryEnabled = false
		chartView.leftAxis.drawBottomYLabelEntryEnabled = false

		chartView.rightAxis.drawGridLinesEnabled = false
		chartView.rightAxis.drawAxisLineEnabled = false
		chartView.rightAxis.drawLabelsEnabled = false
		chartView.rightAxis.drawZeroLineEnabled = false
		chartView.rightAxis.drawTopYLabelEntryEnabled = false
		chartView.rightAxis.drawBottomYLabelEntryEnabled = false

		chartView.zoom(scaleX: 4.0, scaleY: 1.0, x: 0, y: 0)
		chartView.doubleTapToZoomEnabled = false
		chartView.pinchZoomEnabled = false
		chartView.setScaleEnabled(false)
	}


}

