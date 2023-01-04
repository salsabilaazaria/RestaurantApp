//
//  NearbyRestoCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Maulana Dimas Iffandi on 02/01/23.
//

import UIKit

class NearbyRestoCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!

	@IBOutlet weak var restaurantNameLabel: UILabel!
	
	@IBOutlet weak var distanceLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func configureNearbyRestoProperty(restaurantName: String, distance: String) {
		
		restaurantNameLabel.attributedText = NSAttributedString.title(text: restaurantName)
		
		distanceLabel.attributedText = NSAttributedString.body(text: distance)
		
		imageView.backgroundColor = .bukaRestoDisabledButton
		
	}
}
