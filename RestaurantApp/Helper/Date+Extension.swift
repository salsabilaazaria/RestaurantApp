//
//  Date+Extension.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 24/01/23.
//

import Foundation

extension Date {
	func dayNumber() -> Int? {
		return ((Calendar.current.dateComponents([.weekday], from: self).weekday) ?? 0 - 1)
	}
}

