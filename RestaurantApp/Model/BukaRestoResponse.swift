//
//  BukaRestoResponse.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 21/12/22.
//

import Foundation
import CoreLocation

struct BukaRestoBaseResponse: Codable {
	let message: String?
	let code: Int?
	let data: [Resto]?
}

struct NearbyResto: Codable {
	let message: String?
	let code: Int?
	let data: [Resto]?
}

struct AllResto: Codable {
	let message: String?
	let code: Int?
	let data: [Resto]?
}

struct CategoryBaseResponse: Codable {
	let message: String?
	let code: Int?
	let data: [Category]?
}

struct MenuBaseResponse: Codable {
	let message: String?
	let code: Int?
	let data: [Menu]?
}

struct Category: Codable {
	let id: String?
	let name: String?
	let description: String?
}

struct Menu: Codable {
	let id: String?
	let category_id: String?
	let name: String?
	let description: String?
	let tags: [String]?
	let price: Int?
	let image_url: String?
}

struct Resto: Codable {
	let id: String?
	let name: String?
	let address: String?
	let latitude: Double?
	let longitude: Double?
	let rating: Float?
	let open_hours: [OpenHours]?
	var distance: String {
		let myLocation = CLLocation(latitude: LocationManager.shared.lat, longitude: LocationManager.shared.long)
		
		let modelLocation = CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
		
		let distance = myLocation.distance(from: modelLocation)
		
		var newDistanceString: String = ""
		let result: Double = distance <= 1000 ? distance : distance/1000
		let distanceString = String(format: "%.2f", result)
		
		if distance <= 1000 {
			newDistanceString = distanceString + String("Meter")
		} else {
			newDistanceString =  distanceString + String("KM")
		}
		
		return newDistanceString
	}
}

struct OpenHours: Codable {
	let day: Int
	let open_hour: String?
	let close_hour: String?
	let timezone: Int
	let is_open: Bool
}
