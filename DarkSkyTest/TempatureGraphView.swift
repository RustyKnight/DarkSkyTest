//
//  TempatureGraphView.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 18/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit
import SwiftSky

struct PointOfInterest {
	var weather: Weather
	var point: CGPoint
	
	static var measureFormatter: MeasurementFormatter = {
		let formatter = MeasurementFormatter()
		formatter.numberFormatter.maximumFractionDigits = 2
		
		return formatter
	}()
	
	var label: String {
		let measure = Measurement(value: weather.forecastTempature, unit: UnitTemperature.celsius)
		return PointOfInterest.measureFormatter.string(from: measure)
	}
}

@IBDesignable
class TempatureGraphView: UIView {

	var model: Model? {
		didSet {
			loadModel()
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUp()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setUp();
	}
	
	func setUp() {
	}
	
	func prepare(rainBar: UIView) {
		rainBar.backgroundColor = UIColor(red: 0, green: 0.047058823529412, blue: 1, alpha: 0.5)
		rainBar.layer.borderColor = UIColor(red: 0, green: 0.047058823529412, blue: 1, alpha: 1).cgColor
		rainBar.layer.borderWidth = 1
	}
	
	// The amount of horizontal spacing between points
	var pointHorizontalGap: CGFloat {
		return frame.size.width / 12.0
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 2688, height: 200)
	}
	
	var forecastPath: UIBezierPath = UIBezierPath()
	var forecastFillPath: UIBezierPath = UIBezierPath()
	var pointsOfInterest: [PointOfInterest] = []
//	var apparentPath: UIBezierPath = UIBezierPath()

	func loadModel() {
		guard let model = model else {
			forecastPath = UIBezierPath()
			forecastFillPath = UIBezierPath()
			pointsOfInterest = []
			return
		}
		
		let min = CGFloat(model.min - 5)
		let max = CGFloat(model.max + 5)
		
		let range = max - min
		
		defer {
			setNeedsDisplay()
		}
		guard model.weather.count > 0 else {
			print("No points for you")
			forecastPath = UIBezierPath()
			forecastFillPath = UIBezierPath()
			pointsOfInterest = []
//			apparentPath = UIBezierPath()
			return
		}
		
		buildForecastPath(model: model, minRange: min, maxRange: max)
//		buildFellsLikePath(minRange: min, maxRange: max)
	}
	
	func buildForecastPath(model: Model, minRange min: CGFloat, maxRange max: CGFloat) {
		let linePath = UIBezierPath()
		let fillPath = UIBezierPath()

		let height = frame.size.height
		let width = frame.size.width

		let range = max - min

		defer {
			forecastPath = linePath
			forecastFillPath = fillPath
		}
		
		pointsOfInterest = []
		
		var points: [CGPoint] = []
		var xPoint: CGFloat = pointHorizontalGap / 2
		for forecast in model.weather {
			let temp = CGFloat(forecast.forecastTempature) - min
			let yPoint = height - ((temp / range) * height)
			
			let point = CGPoint(x: xPoint, y: yPoint)
			points.append(point)
			xPoint += pointHorizontalGap
			
			pointsOfInterest.append(PointOfInterest(weather: forecast, point: point))
		}
		
		let first = points.first!
		let last = points.last!
		
		points.insert(CGPoint(x: 0, y: first.y), at: 0)
		points.insert(CGPoint(x: width, y: last.y), at: points.count)
		
		var p1 = points.first!
		linePath.move(to: p1)
		
		fillPath.move(to: CGPoint(x: p1.x, y: height))
		fillPath.addLine(to: p1)
		
		for index in 1..<points.count {
			let p2 = points[index]
			let midPoint = midPointBetween(p1, and: p2)
			
			let cp1 = controlPointBetween(midPoint, and: p1)
			let cp2 = controlPointBetween(midPoint, and: p2)
			
			linePath.addQuadCurve(to: midPoint, controlPoint: cp1)
			linePath.addQuadCurve(to: p2, controlPoint: cp2)
			
			fillPath.addQuadCurve(to: midPoint, controlPoint: cp1)
			fillPath.addQuadCurve(to: p2, controlPoint: cp2)
			
			p1 = p2
		}
		
		fillPath.addLine(to: CGPoint(x: p1.x, y: height))
		fillPath.close()
	}
	
//	func buildFellsLikePath(minRange min: CGFloat, maxRange max: CGFloat) {
//		let linePath = UIBezierPath()
//
//		let height = frame.size.height
//		let width = frame.size.width
//
//		let range = max - min
//
//		defer {
//			apparentPath = linePath
//		}
//
//		var points: [CGPoint] = []
//		var xPoint: CGFloat = pointHorizontalGap / 2
//		for forecast in model.weather {
//			let temp = CGFloat(forecast.apparentTempature) - min
//			let yPoint = height - ((temp / range) * height)
//
//			points.append(CGPoint(x: xPoint, y: yPoint))
//			xPoint += pointHorizontalGap
//		}
//
//		let first = points.first!
//		let last = points.last!
//
//		points.insert(CGPoint(x: 0, y: first.y), at: 0)
//		points.insert(CGPoint(x: width, y: last.y), at: points.count)
//
//		var p1 = points.first!
//		linePath.move(to: p1)
//
//		for index in 1..<points.count {
//			let p2 = points[index]
//			let midPoint = midPointBetween(p1, and: p2)
//
//			let cp1 = controlPointBetween(midPoint, and: p1)
//			let cp2 = controlPointBetween(midPoint, and: p2)
//
//			linePath.addQuadCurve(to: midPoint, controlPoint: cp1)
//			linePath.addQuadCurve(to: p2, controlPoint: cp2)
//
//			p1 = p2
//		}
//	}

	
	func midPointBetween(_ p1: CGPoint, and p2: CGPoint) -> CGPoint {
		return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2)
	}
	
	func controlPointBetween(_ p1: CGPoint, and p2: CGPoint) -> CGPoint {
		var controlPoint = midPointBetween(p1, and: p2)
		let diff = abs(p2.y - controlPoint.y)
		if p1.y < p2.y {
			controlPoint.y += diff
		} else if p1.y > p2.y {
			controlPoint.y -= diff
		}
		
		return controlPoint
	}

	override func draw(_ rect: CGRect) {
		super.draw(rect)
		guard !forecastPath.isEmpty else {
			return
		}
		
		if let ctx = UIGraphicsGetCurrentContext() {
			ctx.saveGState()
			forecastFillPath.addClip()
			let cgColors: [CGColor] = [
				UIColor.yellow.cgColor,
				UIColor.red.cgColor
			]
			if let gradient = CGGradient(colorsSpace: nil, colors: cgColors as CFArray, locations: nil) {
				ctx.drawLinearGradient(gradient, start: CGPoint(x: 0, y: frame.size.height), end: CGPoint(x: 0, y: 0), options: [])
			}
			ctx.restoreGState()
		} else {
			UIColor.magenta.set()
			forecastFillPath.fill()
		}
		
		UIColor.black.set()
		forecastPath.stroke()
		
//		let dashes: [CGFloat] = [4, 4]
//		apparentPath.setLineDash(dashes, count: dashes.count, phase: 0.0)
//		apparentPath.lineCapStyle = .round
//		apparentPath.lineJoinStyle = .round
//		UIColor.blue.set()
//		apparentPath.stroke()
		
		for poi in pointsOfInterest {
			let point = poi.point
			
			let circlePath = UIBezierPath(
				arcCenter: point,
				radius: 6,
				startAngle: CGFloat(0),
				endAngle: CGFloat(Double.pi * 2),
				clockwise: true)
			
			UIColor.yellow.setFill()
			UIColor.red.setStroke()
			circlePath.fill()
			circlePath.stroke()
			
			let textPoint = CGPoint(x: point.x, y: point.y - 6)
			
			draw(text: poi.label, at: textPoint)
		}
	}
	
	func draw(text: String, at: CGPoint) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		
		let attributes = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0),
			NSAttributedString.Key.foregroundColor: UIColor.black
		]
		
		let attributedString = NSAttributedString(string: text, attributes: attributes)
		
		let size = attributedString.size()
		
		let x = at.x - (size.width / 2)
		
		let stringRect = CGRect(x: x, y: at.y - size.height, width: size.width, height: size.height)
		attributedString.draw(in: stringRect)
	}

}

//public extension NSLayoutConstraint {
//
//	func changeMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
//		let newConstraint = NSLayoutConstraint(
//			item: firstItem!,
//			attribute: firstAttribute,
//			relatedBy: relation,
//			toItem: secondItem,
//			attribute: secondAttribute,
//			multiplier: multiplier,
//			constant: constant)
//		newConstraint.priority = priority
//
//		NSLayoutConstraint.deactivate([self])
//		NSLayoutConstraint.activate([newConstraint])
//
//		return newConstraint
//	}
//
//}
