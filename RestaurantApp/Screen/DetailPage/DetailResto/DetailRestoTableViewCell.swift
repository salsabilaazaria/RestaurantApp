//
//  DetailRestoTableViewCell.swift
//  RestaurantApp
//
//  Created by Maulana Dimas Iffandi on 23/01/23.
//

import UIKit

class DetailRestoTableViewCell: UITableViewCell {

	@IBOutlet weak var restaurantNameLabel: UILabel!
	@IBOutlet weak var restaurantOperationalLabel: UILabel!
	@IBOutlet weak var restaurantAddressLabel: UILabel!
	@IBOutlet weak var restaurantIsOpen: UILabel!
	
	
	let identifier = "DetailRestoTableViewCell"
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setStateRestaurant(isOpen: Bool) {
		
	}
	
	func setPropertyLabel(restoName: String, operationalTime: String, address: String){
		restaurantNameLabel.attributedText = NSAttributedString.body(text: restoName)
		restaurantOperationalLabel.attributedText = NSAttributedString.body(text: operationalTime)
		restaurantAddressLabel.attributedText = NSAttributedString.body(text: address)
	}
    
}
