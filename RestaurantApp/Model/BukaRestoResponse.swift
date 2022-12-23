//
//  TopRestoResponse.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 21/12/22.
//

import Foundation

struct TopResto: Codable {
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
}

struct OpenHours: Codable {
	let day: Int
	let open_hour: String?
	let close_hour: String?
	let timezone: Int
	let is_open: Bool
}
