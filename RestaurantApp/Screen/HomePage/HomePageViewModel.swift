//
//  HomePageViewModel.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 23/12/22.
//

import Foundation

class HomePageViewModel {
	var onReload: (() -> Void)?
	
	var topResto: TopResto? = nil {
		didSet {
			self.onReload?()
		}
	}
	
	init() {

	}
	
	func fetchTopResto() {
		let url = URL(string: "https://private-893e7e-bukaresto.apiary-mock.com/restaurant/top")
		URLSession.shared.requestData(url: url, expecting: TopResto.self) { result in
			switch result {
			case .success(let topResto):
				self.topResto = topResto
				print("SAL \(topResto)")
			case .failure(let error):
				print("SAL error\(error)")
			}
		}
	}

}
