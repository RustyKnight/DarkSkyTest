//
//  TempatureGraphView.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 18/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit
import SwiftSky

class TempatureGraphView: UIView {
	
	@IBOutlet weak var rainBar01: UIView!
	@IBOutlet weak var rainBar02: UIView!
	@IBOutlet weak var rainBar03: UIView!
	@IBOutlet weak var rainBar04: UIView!
	@IBOutlet weak var rainBar05: UIView!
	@IBOutlet weak var rainBar06: UIView!
	@IBOutlet weak var rainBar07: UIView!
	@IBOutlet weak var rainBar08: UIView!
	@IBOutlet weak var rainBar09: UIView!
	@IBOutlet weak var rainBar10: UIView!
	@IBOutlet weak var rainBar11: UIView!
	@IBOutlet weak var rainBar12: UIView!
	
	@IBOutlet weak var rainBar01Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar02Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar03Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar04Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar05Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar06Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar07Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar08Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar09Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar10Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar11Constraint: NSLayoutConstraint!
	@IBOutlet weak var rainBar12Constraint: NSLayoutConstraint!

	var rainBars: [UIView] = []
	var rainBarConstraints: [NSLayoutConstraint] = []

	var model: Model = Model(dataPoints: []) {
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
		rainBars.append(rainBar01)
		rainBars.append(rainBar02)
		rainBars.append(rainBar03)
		rainBars.append(rainBar04)
		rainBars.append(rainBar05)
		rainBars.append(rainBar06)
		rainBars.append(rainBar07)
		rainBars.append(rainBar08)
		rainBars.append(rainBar09)
		rainBars.append(rainBar10)
		rainBars.append(rainBar11)
		rainBars.append(rainBar12)

		rainBarConstraints.append(rainBar01Constraint)
		rainBarConstraints.append(rainBar02Constraint)
		rainBarConstraints.append(rainBar03Constraint)
		rainBarConstraints.append(rainBar04Constraint)
		rainBarConstraints.append(rainBar05Constraint)
		rainBarConstraints.append(rainBar06Constraint)
		rainBarConstraints.append(rainBar07Constraint)
		rainBarConstraints.append(rainBar08Constraint)
		rainBarConstraints.append(rainBar09Constraint)
		rainBarConstraints.append(rainBar10Constraint)
		rainBarConstraints.append(rainBar11Constraint)
		rainBarConstraints.append(rainBar12Constraint)

		for rainBar in rainBars {
			prepare(rainBar: rainBar)
		}
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

	func loadModel() {
		let min = model.min - 5
		let max = model.max + 5
		
		let range = CGFloat(max - min)

		let height = frame.size.height
		let width = frame.size.width
		
		let linePath = UIBezierPath()
		let fillPath = UIBezierPath()
		
		defer {
			forecastPath = linePath
			forecastFillPath = fillPath
			setNeedsDisplay()
		}
		guard model.weather.count > 0 else {
			print("No points for you")
			return
		}
		
		for index in 0..<model.weather.count {
			let forecast = model.weather[index]
//			let constraint = rainBarConstraints[index]
//			constraint.changeMultiplier(multiplier: CGFloat(forecast.chanceOfRain))
		}

		var points: [CGPoint] = []
		var xPoint: CGFloat = pointHorizontalGap / 2
		for forecast in model.weather {
			let temp = CGFloat(forecast.forecastTempature - min)
			let yPoint = height - ((temp / range) * height)
			
			points.append(CGPoint(x: xPoint, y: yPoint))
			xPoint += pointHorizontalGap
		}
		
		let first = points.first!
		let last = points.last!
		
		points.insert(CGPoint(x: 0, y: first.y), at: 0)
		points.insert(CGPoint(x: width, y: last.y), at: points.count)

		print("Rendering \(points.count) points")
		
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
		
		UIColor.blue.set()
		forecastPath.stroke()
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
