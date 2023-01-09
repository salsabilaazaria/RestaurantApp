//
//  DetailPageViewModel.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 06/01/23.
//

import Foundation

struct RestoMenu {
	var categoryId: String?
	var categoryName: String?
	var menus: [Menu]?
}

class DetailPageViewModel {
	var onReload: (() -> Void)?
	var onReloadNearbySection: (() -> Void)?
	
	var allCategory: [Category]? = nil {
		didSet {
			self.finishedAllFetch = self.menu != nil && self.allCategory != nil
		}
	}
	
	var menu: [Menu]? = nil {
		didSet {
			self.finishedAllFetch = self.menu != nil && self.allCategory != nil
		}
	}
	
	var restoMenu: [RestoMenu]? = nil {
		didSet {
			self.onReload?()
		}
	}
	
	var finishedAllFetch: Bool? = nil {
		didSet {
			guard finishedAllFetch == true else {
				return
			}
			self.createData()
		}
	}

	init() {
		
	}
	
	private func createData() {
		guard let menus = self.menu else {
			return
		}
		
		let menuData = Dictionary(grouping: menus) { $0.category_id }
		
		let restoMenuData: [RestoMenu] = menuData.map { (key, values) in
			guard let key = key,
				let categoryName = findCategory(categoryId: key) else {
				return nil
			}
			return RestoMenu(categoryId: key, categoryName: categoryName, menus: values)
		}.compactMap{ $0 }
		
		self.restoMenu = restoMenuData.sorted { $0.categoryId ?? "" < $1.categoryId ?? ""}
	}
	
	private func findCategory(categoryId: String) -> String? {
		guard let allCategory = allCategory else {
			return nil
		}

		let cat = allCategory.first(where: {
			$0.id == categoryId
		})
		
		return cat?.name 
	}
	
	func fetchCategory() {
		let url = URL(string: "https://private-893e7e-bukaresto.apiary-mock.com/category/1")
		URLSession.shared.requestData(url: url, expecting: CategoryBaseResponse.self) { result in
			switch result {
			case .success(let baseResponse):
				self.allCategory = baseResponse.data
				print("BukaResto Fetch Category Result\(baseResponse)")
			case .failure(let error):
				print("BukaResto Fetch Category Error\(error.localizedDescription)")
			}
		}
	}
	
	func fetchMenu() {
		let url = URL(string: "https://private-893e7e-bukaresto.apiary-mock.com/food/1")
		URLSession.shared.requestData(url: url, expecting: MenuBaseResponse.self) { result in
			switch result {
			case .success(let baseResponse):
				self.menu = baseResponse.data
				print("BukaResto Fetch Menu Result\(baseResponse)")
			case .failure(let error):
				print("BukaResto Fetch Menu Error\(error.localizedDescription)")
			}
		}
	}
	
}
