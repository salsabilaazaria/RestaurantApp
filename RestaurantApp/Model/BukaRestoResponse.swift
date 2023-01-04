//
//  BukaRestoResponse.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 21/12/22.
//

import Foundation
import CoreLocation

struct TopResto: Codable {
	let message: String?
	let code: Int?
	let data: [Resto]?
}

struct NearbyResto: Codable {
	let message: String?
	let code: Int?
	let data: [Resto]?
}

struct Resto: Codable {
	let id: String?
	let name: String?
	let address: String?
	let latitude: Double?
	let longitude: Double?
	let rating: Float?
	let open_hours: [OpenHours]?
	var distance: Double {
		let myLocation = CLLocation(latitude: LocationManager.shared.lat, longitude: LocationManager.shared.long)
		
		let modelLocation = CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
		
		let distance = myLocation.distance(from: modelLocation)
		
//		if (distance <= 1000) {
//			return distance
//		} else {
//			return distance / 1000
//		}
		
		return distance
	}
}

struct OpenHours: Codable {
	let day: Int
	let open_hour: String?
	let close_hour: String?
	let timezone: Int
	let is_open: Bool
}
