//
//  MenuSectionTableView.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 04/01/23.
//

import UIKit

class MenuSectionTableView: UITableViewCell {
	
	@IBOutlet weak var menuTableView: UITableView!
	override func awakeFromNib() {
		super.awakeFromNib()
		configureTableView()
		// Initialization code
	}
	
	private func configureTableView() {
		menuTableView.delegate = self
		menuTableView.dataSource = self
		
	}
	
}

extension MenuSectionTableView: UITableViewDelegate {
	
}

extension MenuSectionTableView: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tableCell = UITableViewCell()
		var contentConfiguration = tableCell.defaultContentConfiguration()
		contentConfiguration.text = "Menu\(indexPath.section)"
		tableCell.contentConfiguration = contentConfiguration
		
		
		return tableCell
		
		
	}
	
	
}

