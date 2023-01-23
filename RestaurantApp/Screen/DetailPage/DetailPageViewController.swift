//
//  DetailPageViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 04/01/23.
//

import UIKit

class DetailPageViewController: UIViewController {
	
	@IBOutlet weak var detailPageTableView: UITableView!
	
	private let detailRestoSectionCellIdentifier = DetailRestoTableViewCell().identifier
	private let menuSectionCellIdentifier = MenuSectionTableView().identifier
	private let menuCategoryCollectionViewCell = MenuCategoryCollectionViewCell().identifier
	
	private let viewModel = DetailPageViewModel()
	
	private var categoryCollectionView: UICollectionView!
	private var headerView: UIView!
	
	private let headerHeight: CGFloat = 50
	
	private var resto: Resto?
	
	init(resto: Resto) {
		self.resto = resto
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		useBukaRestoBaseNavBar()
		viewModel.fetchCategory()
		viewModel.fetchMenu()
		
		configureTableView()
		configureViewModel()
		configureCategoryCollectionView()
		configureHeaderMenuSection()
		configureNavigationBar()
	}
		
	private func configureNavigationBar() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = UIColor.bukaRestoDarkGreen
		navigationController?.navigationBar.isTranslucent = true
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
	}
	
	private func configureTableView() {
		detailPageTableView.delegate = self
		detailPageTableView.dataSource = self
		detailPageTableView.register(UINib(nibName: menuSectionCellIdentifier, bundle: nil), forCellReuseIdentifier: menuSectionCellIdentifier)
		detailPageTableView.sectionHeaderTopPadding = 0
		detailPageTableView.register(UINib(nibName: detailRestoSectionCellIdentifier, bundle: nil), forCellReuseIdentifier: detailRestoSectionCellIdentifier)
	}
	
	private func configureViewModel() {
		viewModel.onReload = { [weak self] in
			DispatchQueue.main.async {
				self?.detailPageTableView.reloadData()
				self?.categoryCollectionView.reloadData()
			}
		}
	}
	
	private func configureCategoryCollectionView() {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		
		categoryCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerHeight), collectionViewLayout: flowLayout)
		categoryCollectionView.isUserInteractionEnabled = true
		categoryCollectionView.showsHorizontalScrollIndicator = false
		categoryCollectionView.contentInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
		
		categoryCollectionView.dataSource = self
		categoryCollectionView.delegate = self
		categoryCollectionView.register(UINib(nibName: menuCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: menuCategoryCollectionViewCell)
	}
	
	private func configureHeaderMenuSection() {
		headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerHeight))
		headerView.addSubview(categoryCollectionView)
	}
	
}

extension DetailPageViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		switch section {
		case 1:
			return headerView
		default:
			return nil
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch section {
		case 1:
			return headerHeight
		default:
			return CGFloat.leastNonzeroMagnitude
		}
	}
	
}

extension DetailPageViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 1:
			return 1
		default:
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: detailRestoSectionCellIdentifier) as? DetailRestoTableViewCell,
				  let restoData = resto else {
					  return UITableViewCell()
				  }
//			cell.restoMenu = restoMenu
//			cell.mainScrollView = tableView
			let openHours = restoData.open_hours
		
			cell.setPropertyLabel(restoName: restoData.name ?? "", operationalTime: "2", address: restoData.address ?? "")
			
			return cell
			
			
		case 1:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: menuSectionCellIdentifier) as? MenuSectionTableView,
				  let restoMenu = viewModel.restoMenu else {
					  return UITableViewCell()
				  }
			cell.restoMenu = restoMenu
			cell.mainScrollView = tableView
			return cell
		default:
			let tableCell = UITableViewCell()
			var contentConfiguration = tableCell.defaultContentConfiguration()
			contentConfiguration.text = "Test\(indexPath.section)"
			tableCell.contentConfiguration = contentConfiguration
					
			return tableCell
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case 0:
			return getFirstSectionHeight()
		case 1:
			return UIScreen.main.bounds.height - headerHeight - (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0) - (navigationController?.navigationBar.frame.height ?? 0)
		default:
			return 0
		}
	}
	
	func getFirstSectionHeight() -> CGFloat {
		return UIScreen.main.bounds.height/2
	}
	
	
}

extension UITableView {
	public override var intrinsicContentSize: CGSize {
		layoutIfNeeded()
		return contentSize
	}

	public override var contentSize: CGSize {
		didSet {
			invalidateIntrinsicContentSize()
		}
	}
}

extension DetailPageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	// MARK: UICollectionViewDataSource
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.restoMenu?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCategoryCollectionViewCell, for: indexPath) as! MenuCategoryCollectionViewCell
		guard let menuCategory = viewModel.restoMenu?[indexPath.row].categoryName  else {
			return cell
		}
		
		cell.setCategoryLabel(text: menuCategory)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let menuCell = detailPageTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? MenuSectionTableView else {
			return
		}
		menuCell.isScrollEnabled = true
		
		let menuCellIndexPath = IndexPath(row: 0, section: indexPath.row)
		menuCell.scrollToIndexPath(indexPath: menuCellIndexPath)
	
	}
}


extension DetailPageViewController: UIScrollViewDelegate {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard let menuCell = detailPageTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? MenuSectionTableView else {
			return
		}
		
		let mainYContentOffSet = scrollView.contentOffset.y
		let cellYContentOffSet = menuCell.menuTableView.contentOffset.y
		let cellHeight: CGFloat = getFirstSectionHeight()
		
		if mainYContentOffSet > cellHeight {
			//maksa supaya cell diatas menu ke hide trs
			let delta = abs(mainYContentOffSet - cellHeight)
			let newCellOffSet = menuCell.menuTableView.contentOffset.y + delta
			scrollView.setContentOffset(CGPoint(x: 0, y: cellHeight), animated: false)
			menuCell.menuTableView.setContentOffset(CGPoint(x: 0, y: newCellOffSet), animated: false)
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
		guard let menuCell = detailPageTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? MenuSectionTableView else {
			return
		}
		
		let mainYContentOffSet = scrollView.contentOffset.y
		let cellHeight: CGFloat = 44
		
		if mainYContentOffSet >= cellHeight {
			scrollView.isScrollEnabled = false
			menuCell.menuTableView.isScrollEnabled = true
		}
		
	}
}



