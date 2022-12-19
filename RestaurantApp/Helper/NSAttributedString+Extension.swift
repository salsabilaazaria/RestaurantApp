//
//  NSAttributedString+Extension.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 19/12/22.
//


import UIKit

enum fontStateStyle {
	case secondary
}

extension NSAttributedString {
	//	static func bold(_ text: String, _ size: CGFloat = 14, _ color: UIColor = .black) -> NSAttributedString {
	//		let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: size, weight: .bold), .foregroundColor: color]
	//		let boldString = NSAttributedString(string: text, attributes: attrs)
	//
	//		return boldString
	//	}
	//
	
	static func title(text: String, size: CGFloat = 14, color: UIColor = .black) -> NSAttributedString {
		let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: size, weight: .semibold), .foregroundColor: color]
		let boldString = NSAttributedString(string: text, attributes: attrs)
		
		return boldString
	}
	
	
	static func body(text: String, size: CGFloat = 12, color: UIColor = .black) -> NSAttributedString {
		let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: size, weight: .regular), .foregroundColor: color]
		let string = NSAttributedString(string: text, attributes: attrs)
		
		return string
	}
	
	static func subBody(text: String, size: CGFloat = 12, color: UIColor = .black, state: fontStateStyle? = nil) -> NSAttributedString {
		if let state = state, state == .secondary {
			let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: size, weight: .light), .foregroundColor: UIColor.bukaRestoSecondaryFontColor]
			let string = NSAttributedString(string: text, attributes: attrs)
			
			return string
		} else {
			let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: size, weight: .light), .foregroundColor: color]
			let string = NSAttributedString(string: text, attributes: attrs)
			
			return string
		}
	}
	
}
