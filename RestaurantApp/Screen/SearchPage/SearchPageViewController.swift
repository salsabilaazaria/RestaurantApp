//
//  SearchPageViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 27/12/22.
//

import UIKit

class SearchPageViewController: UIViewController {
	
	@IBOutlet weak var searchBarContainer: UIView!
	@IBOutlet weak var searchTextField: UITextField!
	
	@IBOutlet weak var searchBarLabel: UILabel!
	@IBOutlet weak var searchBarImage: UIImageView!
	
	@IBOutlet weak var topSearchCollectionView: UICollectionView!
	@IBOutlet weak var searchResultTableView: UITableView!

	private let topSearchCellIdentifier = "TopSearchCollectionViewCell"
	
	let topSearchArray = ["Ramen", "All You Can Eat", "Yakiniku", "Cafe", "Coffee", "Sushi", "Indomie", "Ayam Bakar Cobek", "Sambel Bakar"]
	
	let isSearching: Bool = false

	override func viewDidLoad() {
        super.viewDidLoad()
		useDarkGreenStatusBar()
	
		self.navigationController?.navigationBar.isHidden = true
		
		configureSearchBar()
		configureRightView()
		configureTableView()
		configureCollectionView()
		
		configuerInitialView()
    }
	
	private func configuerInitialView() {
		self.topSearchCollectionView.isHidden = false
		self.searchBarImage.isHidden = false
		self.searchResultTableView.isHidden = true
		self.searchBarLabel.isHidden = true
	}
	
	private func configureSearchBar() {
		searchBarContainer.backgroundColor = .bukaRestoDarkGreen
		searchTextField.delegate = self
	}
	
	private func configureRightView() {
		let searchIconImage =  UIImage(named: "search-icon.png")
		searchBarImage.image = searchIconImage
		let searchImageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchTapped))
		searchBarImage.isUserInteractionEnabled = true
		searchBarImage.addGestureRecognizer(searchImageTapRecognizer)
		
		
		searchBarLabel.attributedText = NSAttributedString.title(text: "CANCEL", color: .white)
		let cancelTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelTapped))
		searchBarLabel.isUserInteractionEnabled = true
		searchBarLabel.addGestureRecognizer(cancelTapRecognizer)
	}
	
	@objc private func searchTapped() {
		self.searchTextField.becomeFirstResponder()
	}
	
	@objc private func cancelTapped() {
		self.searchTextField.resignFirstResponder()
		configuerInitialView()
	}
	
	private func configureTableView() {
		searchResultTableView.dataSource = self
		searchResultTableView.delegate = self
	}
	
	private func configureCollectionView() {
		// Set up the flow layout's cell alignment:
		let flowLayout = AlignedCollectionViewFlowLayout()
		flowLayout.horizontalAlignment = .leading
		// Enable automatic cell-sizing with Auto Layout:
		flowLayout.estimatedItemSize = .init(width: 100, height: 40)

		topSearchCollectionView.collectionViewLayout = flowLayout
		topSearchCollectionView?.dataSource = self
		topSearchCollectionView?.register(UINib(nibName: topSearchCellIdentifier, bundle: nil), forCellWithReuseIdentifier: topSearchCellIdentifier)
		topSearchCollectionView.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
		topSearchCollectionView.backgroundColor = .bukaRestoLightGray
	}
	
	private func configureEditingView() {
		self.topSearchCollectionView.isHidden = true
		self.searchResultTableView.isHidden = false
		self.searchBarImage.isHidden = true
		self.searchBarLabel.isHidden = false
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelTapped))
		self.searchBarLabel.addGestureRecognizer(tapGestureRecognizer)
	}

}

extension SearchPageViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		guard textField == searchTextField else {
			return
		}
		configureEditingView()
	
	}
}


extension SearchPageViewController: UITableViewDelegate {
	
}

extension SearchPageViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		

			let tableCell = UITableViewCell()
			var contentConfiguration = tableCell.defaultContentConfiguration()
			contentConfiguration.text = "Test"
			tableCell.contentConfiguration = contentConfiguration
		
		
		return tableCell
	}
	
	
}

extension SearchPageViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return topSearchArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topSearchCellIdentifier, for: indexPath) as? TopSearchCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.setTopSearchLabel(text: topSearchArray[indexPath.row])
		
		return cell
	}
}





