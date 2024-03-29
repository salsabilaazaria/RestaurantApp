//
//  HomePageViewModel.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 23/12/22.
//

import Foundation

class HomePageViewModel {
	var onReload: (() -> Void)?
	var onReloadNearbySection: (() -> Void)?
	var onReloadAllRestoSection: (() -> Void)?
	
	var topResto: BukaRestoBaseResponse? = nil {
		didSet {
			self.onReload?()
		}
	}
	
	var nearbyResto: NearbyResto? = nil {
		didSet {
			self.onReloadNearbySection?()
		}
	}
	
	var allResto: AllResto? = nil {
		didSet {
			self.onReloadAllRestoSection?()
		}
	}
		
	init() {

	}
	
	func fetchTopResto() {
		let url = URL(string: "https://private-893e7e-bukaresto.apiary-mock.com/restaurant/top")
		URLSession.shared.requestData(url: url, expecting: BukaRestoBaseResponse.self) { result in
			switch result {
			case .success(let topResto):
				self.topResto = topResto
				print("SAL \(topResto)")
			case .failure(let error):
				print("SAL error\(error)")
			}
		}
	}
	
	func fetchNearbyResto(latitude: String, longitude: String) {
		let url = URL(string: "https://private-893e7e-bukaresto.apiary-mock.com/restaurant/nearme?latitude=\(latitude)&longitude=\(longitude)")
		URLSession.shared.requestData(url: url, expecting: NearbyResto.self) { result in

			switch result {
			case .success(let nearbyResto):
				var sortedData = nearbyResto.data?.sorted(by: { leftItem, righItem in
					return leftItem.distance < righItem.distance
				})
				
				let newNearbyResto = NearbyResto(message: nearbyResto.message, code: nearbyResto.code, data: sortedData)
				
				self.nearbyResto = newNearbyResto
				print("DIM \(nearbyResto)")
			case .failure(let error):
				print("DIM error\(error)")
			}
		}
	}
	
	func fetchAllResto() {
		let url = URL(string: "https://private-893e7e-bukaresto.apiary-mock.com/restaurant/all?page=1")
		URLSession.shared.requestData(url: url, expecting: AllResto.self) { result in
			switch result {
			case .success(let allResto):
				self.allResto = allResto
				print("DIM ALL RESTO \(allResto)")
			case .failure(let error):
				print("DIM ALL RESTO error\(error)")
			}
		}
	}
}
