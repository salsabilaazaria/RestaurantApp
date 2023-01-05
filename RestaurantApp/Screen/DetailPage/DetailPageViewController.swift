//
//  DetailPageViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 04/01/23.
//

import UIKit

class DetailPageViewController: UIViewController {
	
	@IBOutlet weak var detailPageTableView: UITableView!
	
	private let menuSectionCellIdentifier = "MenuSectionTableView"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureTableView()
		// Do any additional setup after loading the view.
	}
	
	private func configureTableView() {
		detailPageTableView.delegate = self
		detailPageTableView.dataSource = self
		detailPageTableView.register(UINib(nibName: menuSectionCellIdentifier, bundle: nil), forCellReuseIdentifier: menuSectionCellIdentifier)
	}
	
}

extension DetailPageViewController: UITableViewDelegate {
	
}

extension DetailPageViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 2:
			return 1
		default:
			return 5
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 2 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: menuSectionCellIdentifier) as? MenuSectionTableView else {
				return UITableViewCell()
			}
			
			return cell
			
		} else {
			let tableCell = UITableViewCell()
			var contentConfiguration = tableCell.defaultContentConfiguration()
			contentConfiguration.text = "Test\(indexPath.section)"
			tableCell.contentConfiguration = contentConfiguration
			
			
			return tableCell
		}
		
		
	}
	
	
}

