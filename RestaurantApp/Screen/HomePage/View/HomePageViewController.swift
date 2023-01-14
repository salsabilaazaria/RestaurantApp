//
//  HomePageViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 20/12/22.
//

import UIKit
import CoreLocation

class HomePageViewController: UIViewController {
	
	@IBOutlet weak var homeCollectionView: UICollectionView!
	private let popUpView: PopUpViewController = PopUpViewController()

	private let viewModel: HomePageViewModel = HomePageViewModel()
	
	private let cellWidth = UIScreen.main.bounds.width
	
	private let notificationCenter = NotificationCenter.default
	private var observer: NSObjectProtocol?
		
	let topRestoCellIdentifier = "TopRestoCollectionViewCell"
	let headerIdentfier = "HeaderCollectionReusableView"
	let footerIdentifier = "TopRestoFooterCollectionReusableView"
	let nearbyRestoCollectionIdentifier = "NearbyRestoSectionCollectionView"
	let allRestoCollectionIdentifier = "AllRestoCollectionViewCell"
	
	var currentOffset: CGPoint = .zero
	var lastContentSize: CGSize = .zero
	var fetchingMore: Bool = false
	
	var alertView: UIAlertController {
		let alert = UIAlertController(title: "Location Service off", message: "", preferredStyle: .alert)
		let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
			self.navigationController?.popViewController(animated: true)
		}
		
		let action = UIAlertAction(title: "Turn on in Settings", style: .default) { _ in
			guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
			
			if UIApplication.shared.canOpenURL(settingsUrl) {
				UIApplication.shared.open(settingsUrl, completionHandler: nil)
			}
		}
		
		alert.addAction(cancel)
		alert.addAction(action)
		
		return alert
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		LocationManager.shared.checkLocationService()
		observerNotification()
	
		fetchAPI()
		configureHomeNavBar()
		setupCollectionView()
		configureViewModel()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		notificationCenter.removeObserver(self)
		
		if let observer = observer {
			notificationCenter.removeObserver(observer)
		}
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
	
	private func fetchAPI() {
		viewModel.fetchTopResto()
		viewModel.fetchAllResto()
	}
	
	private func configureViewModel() {
		viewModel.onReload = { [weak self] in
			DispatchQueue.main.async {
				self?.homeCollectionView.reloadData()
			}
			
		}
		
		viewModel.onReloadAllRestoSection = { [weak self] in
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
		homeCollectionView.bounces = false
		registerCell()
	}
	
	private func registerCell() {
		homeCollectionView.register(UINib.init(nibName: headerIdentfier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentfier)
		homeCollectionView.register(UINib(nibName: topRestoCellIdentifier, bundle: nil), forCellWithReuseIdentifier: topRestoCellIdentifier)
		homeCollectionView.register(UINib(nibName: nearbyRestoCollectionIdentifier, bundle: nil), forCellWithReuseIdentifier: nearbyRestoCollectionIdentifier)
		homeCollectionView.register(UINib(nibName: allRestoCollectionIdentifier, bundle: nil), forCellWithReuseIdentifier: allRestoCollectionIdentifier)
		homeCollectionView.register(UINib.init(nibName: footerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifier)
	}
	
	@objc func seeMoreTapped(_ sender: UITapGestureRecognizer) {
		popUpView.modalPresentationStyle = .overFullScreen
		self.present(popUpView, animated: false, completion: nil)
	}
	
	private func observerNotification() {
		notificationCenter.addObserver(forName: .sharedLocation, object: nil, queue: .main) { notification in
			
			guard let object = notification.object as? [String: Any] else { return }
			guard let error = object["error"] as? Bool else { return }
			
			if error {
				print("error to access location service.")
				self.present(self.alertView, animated: true, completion: nil)
			} else {
				guard let location = object["location"] as? CLLocation else { return }
					
				let lat = (location.coordinate.latitude)
				let long = (location.coordinate.longitude)

				self.viewModel.fetchNearbyResto(latitude: String(format: "%f", lat), longitude: String(format: "%f", long))
			}
			
		}
	}
}


extension HomePageViewController: UICollectionViewDelegateFlowLayout {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if indexPath.section == 0 {
			return CGSize(width: cellWidth, height: 40)
		} else if indexPath.section == 2 {
			let paddingRight: CGFloat = 16
			let paddingLeft: CGFloat = 16
			let spacingItem: CGFloat = 12
			
			let width = (cellWidth - (paddingLeft + paddingRight + spacingItem))/2
			
			return CGSize(width: width, height: 175)
		}
		return CGSize(width: cellWidth, height: 100)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		if section == 2 {
			return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		}
		
		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 40)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 30)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		
		if section == 2 {
			return 12
		}
		
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

}

extension HomePageViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			return 3
		} else if section == 2 {
			return viewModel.allResto?.data?.count ?? 0
		} else {
			return 1
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		switch kind {
			
		case UICollectionView.elementKindSectionHeader:
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentfier, for: indexPath) as! HeaderCollectionReusableView
			
			if indexPath.section == 0 {
				headerView.configureTitleLabel(text: "Top Resto")
			} else if indexPath.section == 1 {
				headerView.configureTitleLabel(text: "Nearby Resto")
			} else if indexPath.section == 2 {
				headerView.configureTitleLabel(text: "All Resto")
			}
			
			return headerView
		case UICollectionView.elementKindSectionFooter:
			if indexPath.section == 0 {
				let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as! TopRestoFooterCollectionReusableView
				footerView.configureFooterLabel(text: "See More >")
				
				let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(seeMoreTapped))
				footerView.addGestureRecognizer(tapGestureRecognizer)
				
				return footerView
			} else {
				let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as! TopRestoFooterCollectionReusableView
				footerView.configureFooterLabel(text: "")
				
				let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(seeMoreTapped))
				footerView.addGestureRecognizer(tapGestureRecognizer)
				
				return footerView
			}
			
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
		else if indexPath.section == 1 {
			guard let nearbyRestoCell = collectionView.dequeueReusableCell(withReuseIdentifier: nearbyRestoCollectionIdentifier, for: indexPath) as? NearbyRestoSectionCollectionView else {
				return UICollectionViewCell()
			}
			
			nearbyRestoCell.viewModel = viewModel
			
			return nearbyRestoCell
		} else if indexPath.section == 2 {
			guard let allRestoCell = collectionView.dequeueReusableCell(withReuseIdentifier: allRestoCollectionIdentifier, for: indexPath) as? AllRestoCollectionViewCell else {
				return UICollectionViewCell()
			}
			
			let allRestoData = viewModel.allResto?.data?[indexPath.row]
			let restaurantName = allRestoData?.name ?? ""
			let distance = allRestoData?.distance ?? ""
			
			allRestoCell.configureAllRestoProperty(restaurantName: restaurantName, distance: distance)
			
			return allRestoCell
		}
		
		return UICollectionViewCell()
		
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {

		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let scrollHeight = scrollView.frame.height
			
		if offsetY > (contentHeight - scrollHeight) {
			if !fetchingMore {
				startFetchingAgain()
			}
		}
		
	}
	
	func startFetchingAgain() {
		fetchingMore = true
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
			self.viewModel.fetchAllResto()
			self.homeCollectionView.reloadData()
			self.fetchingMore = false
		}
	}
	
}
