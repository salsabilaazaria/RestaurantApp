//
//  SearchPageViewModel.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 02/01/23.
//

import Foundation

class SearchPageViewModel {
	var onReloadSearchTable: (() -> Void)?
	
	var searchResult: [Resto]? = nil {
		didSet {
			self.onReloadSearchTable?()
		}
	}
	
	init() {

	}
	
	func fetchSearch(keyword: String) {
		let queryItems = [URLQueryItem(name: "page", value: "1"), URLQueryItem(name: "keyword", value: keyword)]
		var urlComponents = URLComponents(string: "https://private-893e7e-bukaresto.apiary-mock.com/restaurant/all")!
		urlComponents.queryItems = queryItems
		let urlSearch = urlComponents.url!
		print(urlSearch)
	
		URLSession.shared.requestData(url: urlSearch, expecting: BukaRestoBaseResponse.self) { result in
			switch result {
			case .success(let baseResult):
				self.searchResult = baseResult.data
				print("SAL search result=\(self.searchResult)")
			case .failure(let error):
				print("SAL error\(error)")
			}
		}
	}

}

