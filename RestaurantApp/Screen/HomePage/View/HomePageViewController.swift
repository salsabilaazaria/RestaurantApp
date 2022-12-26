//
//  HomePageViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 20/12/22.
//

import UIKit

class HomePageViewController: UIViewController {
	
	@IBOutlet weak var homeCollectionView: UICollectionView!
	
	private let viewModel: HomePageViewModel = HomePageViewModel()
	
	private let cellWidth = UIScreen.main.bounds.width
	
	
	let topRestoCellIdentifier = "TopRestoCollectionViewCell"
	let headerIdentfier = "HeaderCollectionReusableView"
	let footerIdentifier = "TopRestoFooterCollectionReusableView"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.fetchTopResto()
		configureHomeNavBar()
		setupCollectionView()
		configureViewModel()
	}
	
	private func configureHomeNavBar() {
		useNavBarWithLeftLogo()
		
		let settingButton = UIButton(type: .custom)
		settingButton.setImage(UIImage(named: "setting-icon.png"), for: .normal)
		let scanButton = UIButton(type: .custom)
		scanButton.setImage(UIImage(named: "scan-icon.png"), for: .normal)
		let searchButton = UIButton(type: .custom)
		searchButton.setImage(UIImage(named: "search-icon.png"), for: .normal)
		
		navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: settingButton),
											  UIBarButtonItem(customView: scanButton),
											  UIBarButtonItem(customView: searchButton)]
	}
	
	private func configureViewModel() {
		viewModel.onReload = { [weak self] in
			DispatchQueue.main.async {
				self?.homeCollectionView.reloadData()
			}
			
		}
	}
	
	private func setupCollectionView() {
		homeCollectionView.backgroundColor = .bukaRestoLightGray
		homeCollectionView.dataSource = self
		homeCollectionView.delegate = self
		homeCollectionView.showsHorizontalScrollIndicator = false
		registerCell()
	}
	
	private func registerCell() {
		homeCollectionView.register(UINib.init(nibName: headerIdentfier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentfier)
		homeCollectionView.register(UINib(nibName: topRestoCellIdentifier, bundle: nil), forCellWithReuseIdentifier: topRestoCellIdentifier)
		homeCollectionView.register(UINib.init(nibName: footerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifier)
	}
	
}


extension HomePageViewController: UICollectionViewDelegateFlowLayout {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if indexPath.section == 0 {
			return CGSize(width: cellWidth, height: 40)
		}
		return CGSize(width: cellWidth, height: 100)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 40)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 30)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

}

extension HomePageViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		switch kind {
			
		case UICollectionView.elementKindSectionHeader:
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentfier, for: indexPath) as! HeaderCollectionReusableView
			
			if indexPath.section == 0 {
				headerView.configureTitleLabel(text: "Top Resto")
			}
			
			return headerView
		case UICollectionView.elementKindSectionFooter:
			let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as! TopRestoFooterCollectionReusableView
			
			if indexPath.section == 0 {
				footerView.configureFooterLabel(text: "See More >")
			}
			
			return footerView
			
		default:
			assert(false, "Unexpected element kind")
		}
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if indexPath.section == 0 {
			guard let topRestoCell = collectionView.dequeueReusableCell(withReuseIdentifier: topRestoCellIdentifier, for: indexPath) as? TopRestoCollectionViewCell else {
				return UICollectionViewCell()
			}
			let topRestoData = viewModel.topResto?.data?[indexPath.row]
			topRestoCell.configureTopRestoLabel(number: "\(indexPath.row + 1)", restoName: topRestoData?.name ?? "Top Resto Cell \(indexPath.row + 1)")
			return topRestoCell
		}
		
		return UICollectionViewCell()
		
	}
	
}



