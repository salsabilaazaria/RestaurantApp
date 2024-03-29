//
//  MenuSectionTableView.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 04/01/23.
//

import UIKit

class MenuSectionTableView: UITableViewCell {
	var onScrollToIndex: (() -> Void)?
	
	@IBOutlet weak var menuTableView: UITableView!
	let identifier = "MenuSectionTableView"
	
	private var lastYContentOffset: CGFloat?
	private let menuCellIdentifier = MenuTableViewCell().identifier
	var mainScrollView: UIScrollView?
	var firstSectionMainCellHeight: CGFloat?
	
	var restoMenu: [RestoMenu]? = nil {
		didSet {
			DispatchQueue.main.async {
				self.menuTableView.reloadData()
			}
		}
	}
	
	var isScrollEnabled: Bool = false {
		didSet {
			self.menuTableView.isScrollEnabled = isScrollEnabled
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
		menuTableView.isScrollEnabled = false
		//buat ilangin putih2 diatas setelah di scroll ke bawah
		menuTableView.insetsLayoutMarginsFromSafeArea = false
	}
	
	func scrollToIndexPath(indexPath: IndexPath) {
		DispatchQueue.main.async {
			self.menuTableView.scrollToRow(at: indexPath, at: .top, animated: true)
			self.lastYContentOffset = self.menuTableView.contentOffset.y
		}
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

extension MenuSectionTableView: UIScrollViewDelegate {

	
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let cellYContentOffSet = scrollView.contentOffset.y
		let mainYContentOffSet = mainScrollView?.contentOffset.y ?? 0
		let firstSectionMainCellHeight = firstSectionMainCellHeight ?? 0

		if cellYContentOffSet <= 0 {
			//table scroll ke atas
			//buat show lagi cell diatas menu pas di scroll keatas
			let delta = abs(cellYContentOffSet)
			var newCellOffSet = (mainScrollView?.contentOffset.y ?? 0) - delta
			
			newCellOffSet = max(newCellOffSet, 0)
			mainScrollView?.setContentOffset(CGPoint(x: 0, y: newCellOffSet), animated: false)
			scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
		}
		
		if cellYContentOffSet > 0,
		   mainYContentOffSet < firstSectionMainCellHeight {
			//to prevent menu table udah ke scroll kebawah tapi cell diatasnya ga ke hide
			let delta = abs(cellYContentOffSet)
			var newCellOffSet = scrollView.contentOffset.y + delta
			newCellOffSet = min(newCellOffSet, firstSectionMainCellHeight)
			mainScrollView?.setContentOffset(CGPoint(x: 0, y: newCellOffSet), animated: false)
		}
		
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		endScrolling(scrollView)
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		endScrolling(scrollView)
	}
	
	private func endScrolling(_ scrollView: UIScrollView) {
		//handling ketika user end scrolling
		let cellYContentOffSet = scrollView.contentOffset.y
		let firstSectionMainCellHeight = firstSectionMainCellHeight ?? 0
		
		if cellYContentOffSet < firstSectionMainCellHeight {
			mainScrollView?.isScrollEnabled = true
			scrollView.isScrollEnabled = false
		}
		
	}
}

