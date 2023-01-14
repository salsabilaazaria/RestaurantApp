//
//  AllRestoCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Maulana Dimas Iffandi on 04/01/23.
//

import UIKit

class AllRestoCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var restaurantImageView: UIImageView!
	@IBOutlet weak var restaurantNameLabel: UILabel!
	@IBOutlet weak var restaurantDistanceLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func configureAllRestoProperty(restaurantName: String, distance: String) {
		restaurantNameLabel.attributedText = NSAttributedString.title(text: restaurantName)
		restaurantDistanceLabel.attributedText = NSAttributedString.body(text: distance)
		restaurantImageView.backgroundColor = .bukaRestoDisabledButton
	}

}
