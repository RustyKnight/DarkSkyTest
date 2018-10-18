//
//  WeatherGraphView.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 18/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit

@IBDesignable
class WeatherGraphView: UIView {

	@IBOutlet weak var nib01: XibView!
	@IBOutlet weak var nib02: XibView!
	@IBOutlet weak var nib03: XibView!
	@IBOutlet weak var nib04: XibView!
	@IBOutlet weak var nib05: XibView!
	@IBOutlet weak var nib06: XibView!
	@IBOutlet weak var nib07: XibView!
	@IBOutlet weak var nib08: XibView!
	@IBOutlet weak var nib09: XibView!
	@IBOutlet weak var nib10: XibView!
	@IBOutlet weak var nib11: XibView!
	@IBOutlet weak var nib12: XibView!
	
	var headerNibs: [XibView] = []

	@IBOutlet weak var nibTempatureGraphView: XibView!
	var tempatureGraphView: TempatureGraphView {
		return nibTempatureGraphView.contentView as! TempatureGraphView
	}
	
	var model: Model = Model(dataPoints: []) {
		didSet {
			tempatureGraphView.model = model
			loadModel()
			
			setNeedsLayout()
			layoutIfNeeded()
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		prepare()
		for nib in headerNibs {
			nib.awakeFromNib()
		}
		setUp()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		prepare()
		for nib in headerNibs {
			nib.prepareForInterfaceBuilder()
		}
		setUp()
	}
	
	func prepare() {
		headerNibs = [
			nib01, nib02, nib03, nib04, nib05, nib06,
			nib07, nib08, nib09, nib10, nib11, nib12,
		]
	}
	
	func setUp() {
		for view in headerNibs {
			let header = self.header(forNib: view)
			header.addBorders(edges: [.right], color: UIColor.darkGray)
		}
	}
	
	func header(at: Int) -> HeaderView {
		return headerNibs[at].contentView as! HeaderView
	}
	
	func header(forNib view: XibView) -> HeaderView {
		return view.contentView as! HeaderView
	}
	
	func loadModel() {
		for index in 0..<model.weather.count {
			let header = self.header(at: index)
			let weather = model.weather[index]
			header.weather = weather
		}
	}
}
