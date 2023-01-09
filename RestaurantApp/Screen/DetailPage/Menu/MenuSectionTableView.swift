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
	
	private let menuCellIdentifier = MenuTableViewCell().identifier
	
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
		menuTableView.register(UINib(nibName: menuCellIdentifier, bundle: nil), forCellReuseIdentifier: menuCellIdentifier)
		menuTableView.isUserInteractionEnabled = false
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
		
		guard let menu = restoMenu?[indexPath.section].menus?[indexPath.row],
			  let cell = tableView.dequeueReusableCell(withIdentifier: menuCellIdentifier) as? MenuTableViewCell else {
			return tableCell
		}
	
		cell.menu = menu
		
		return cell
	}
	
	
}

