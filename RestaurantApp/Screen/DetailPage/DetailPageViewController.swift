//
//  DetailPageViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 04/01/23.
//

import UIKit

class DetailPageViewController: UIViewController {
	
	@IBOutlet weak var detailPageTableView: UITableView!
	
	private let menuSectionCellIdentifier = MenuSectionTableView().identifier
	private let menuCategoryCollectionViewCell = MenuCategoryCollectionViewCell().identifier
	
	private let viewModel = DetailPageViewModel()
	
	private var categoryCollectionView: UICollectionView!
	private var headerView: UIView!
	
	private let headerHeight: CGFloat = 50
	
	override func viewDidLoad() {
		super.viewDidLoad()
		useDarkGreenNavBar()
		viewModel.fetchCategory()
		viewModel.fetchMenu()
		
		configureTableView()
		configureViewModel()
		configureCategoryCollectionView()
		configureHeaderMenuSection()
		
	}
	
	private func configureTableView() {
		detailPageTableView.delegate = self
		detailPageTableView.dataSource = self
		detailPageTableView.register(UINib(nibName: menuSectionCellIdentifier, bundle: nil), forCellReuseIdentifier: menuSectionCellIdentifier)
		detailPageTableView.sectionHeaderTopPadding = 0
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
		case 1:
			guard let cell = tableView.dequeueReusableCell(withIdentifier: menuSectionCellIdentifier) as? MenuSectionTableView,
				  let restoMenu = viewModel.restoMenu else {
					  return UITableViewCell()
				  }
			cell.restoMenu = restoMenu

			return cell
		default:
			let tableCell = UITableViewCell()
			var contentConfiguration = tableCell.defaultContentConfiguration()
			contentConfiguration.text = "Test\(indexPath.section)"
			tableCell.contentConfiguration = contentConfiguration
					
			return tableCell
		}
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
}

