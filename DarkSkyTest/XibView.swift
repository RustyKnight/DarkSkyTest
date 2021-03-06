//
//  XibView.swift
//  DarkSkyTest
//
//  Created by Shane Whitehead on 18/10/18.
//  Copyright © 2018 Beam Communications. All rights reserved.
//

import UIKit

@IBDesignable
class XibView: UIView {
	
	var contentView:UIView?
	@IBInspectable var nibName:String?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		xibSetup()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		xibSetup()
		contentView?.prepareForInterfaceBuilder()
	}
	
	func xibSetup() {
		guard let view = loadViewFromNib() else { return }
		view.frame = bounds
		view.autoresizingMask =	[.flexibleWidth, .flexibleHeight]
		addSubview(view)
		contentView = view
	}
	
	func loadViewFromNib() -> UIView? {
		guard let nibName = nibName else { return nil }
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: nibName, bundle: bundle)
		return nib.instantiate(
			withOwner: self,
			options: nil).first as? UIView
	}}
