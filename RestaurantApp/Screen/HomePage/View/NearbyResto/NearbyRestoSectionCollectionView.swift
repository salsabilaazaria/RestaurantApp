//
//  NearbyRestoSectionCollectionView.swift
//  RestaurantApp
//
//  Created by Maulana Dimas Iffandi on 02/01/23.
//

import UIKit

struct MyLocation {
	var nearbyResto: [Resto?]
}

class NearbyRestoSectionCollectionView: UICollectionViewCell {

	@IBOutlet weak var nearbyRestoCollectionView: UICollectionView!
	
	let nearbyCollectionViewCellIdentifier = "NearbyRestoCollectionViewCell"
			
	var viewModel: HomePageViewModel? {
		didSet {
			configureViewModel()
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		setupCollectionView()
    }
		
	private func setupCollectionView() {
		registerCell()
		nearbyRestoCollectionView.delegate = self
		nearbyRestoCollectionView.dataSource = self
		nearbyRestoCollectionView.backgroundView = nil;
		nearbyRestoCollectionView.backgroundColor = .bukaRestoLightGray
		nearbyRestoCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
	}
	
	private func configureViewModel() {
		viewModel?.onReloadNearbySection = { [weak self] in
			DispatchQueue.main.async {
				self?.nearbyRestoCollectionView.reloadData()
			}
		}
	}
	
	private func registerCell() {
		nearbyRestoCollectionView.register(UINib(nibName: nearbyCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: nearbyCollectionViewCellIdentifier)
	}
}

extension NearbyRestoSectionCollectionView: UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 180, height: 120)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 8
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}

extension NearbyRestoSectionCollectionView: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let dataCount = viewModel?.nearbyResto?.data?.count ?? 0
		
		return dataCount
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let nearbyRestoCell = collectionView.dequeueReusableCell(withReuseIdentifier: nearbyCollectionViewCellIdentifier, for: indexPath) as? NearbyRestoCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let nearbyRestoData = viewModel?.nearbyResto?.data?[indexPath.row]
		let restoName = nearbyRestoData?.name ?? ""
		let distance = nearbyRestoData?.distance ?? 0
	
		var newDistanceString: String = ""
		let result: Double = distance <= 1000 ? distance : distance/1000
		let distanceString = String(format: "%.2f", result)
		
		if distance <= 1000 {
			newDistanceString = distanceString + String("Meter")
		} else {
			newDistanceString =  distanceString + String("KM")
		}
		
		nearbyRestoCell.configureNearbyRestoProperty(restaurantName: "\(restoName)", distance: "\(newDistanceString)")
		
		nearbyRestoCell.backgroundColor = .white
		
		return nearbyRestoCell
	}
	
}



