//
//  MenuSectionTableView.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 04/01/23.
//

import UIKit

class MenuSectionTableView: UITableViewCell {
	
	@IBOutlet weak var menuTableView: UITableView!
	let identifier = "MenuSectionTableView"
	
	var restoMenu: [RestoMenu]? = nil {
		didSet {
			DispatchQueue.main.async {
				self.menuTableView.reloadData()
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		configureTableView()
	}
	
	private func configureTableView() {
		menuTableView.delegate = self
		menuTableView.dataSource = self
		menuTableView.sectionHeaderTopPadding = 0
	}
}

extension MenuSectionTableView: UITableViewDelegate {

	
}

extension MenuSectionTableView: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return restoMenu?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return restoMenu?[section].menus?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return restoMenu?[section].categoryName
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tableCell = UITableViewCell()
		
		guard let menu = restoMenu?[indexPath.section].menus?[indexPath.row].name else {
			return tableCell
		}
		
		var contentConfiguration = tableCell.defaultContentConfiguration()
		contentConfiguration.text = "\(menu) with IndexPath row\(indexPath.row) and section\(indexPath.section)"
		tableCell.contentConfiguration = contentConfiguration
		
		return tableCell
	}
	
	
}

