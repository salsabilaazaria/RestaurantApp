//
//  DetailRestoTableViewCell.swift
//  RestaurantApp
//
//  Created by Maulana Dimas Iffandi on 23/01/23.
//

import UIKit

class DetailRestoTableViewCell: UITableViewCell {

	@IBOutlet weak var restoImage: UIImageView!
	@IBOutlet weak var restoInfoView: UIView!
	@IBOutlet weak var restoInfoStack: UIStackView!
	@IBOutlet weak var leftRestoInfoStack: UIStackView!
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
	
	func setRestoName(restoName: String){
		restaurantNameLabel.attributedText = NSAttributedString.body(text: restoName)
	}
	
	func setRestoAddress(address: String){
		restaurantAddressLabel.attributedText = NSAttributedString.body(text: address)
	}
	
	func setRestoOpenHours(restoOpenHours: OpenHours?, isOpen: Bool?) {
		guard let restoOpenHours = restoOpenHours, let isOpen = isOpen else {
			return
		}
		restaurantOperationalLabel.attributedText = NSAttributedString.body(text: "\(restoOpenHours.open_hour ?? "") - \(restoOpenHours.close_hour ?? "")")
		
		let openText = NSAttributedString.body(text: "OPEN TODAY", color: .bukaRestoDarkGreen)
		let closeText = NSAttributedString.body(text: "CLOSED", color: .bukaRestoErrorFontColor)
		restaurantIsOpen.attributedText = isOpen ? openText : closeText
	}
	
	
    
}
