//
//  HeaderCollectionReusableView.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 23/12/22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

	@IBOutlet weak var titleLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
	func configureTitleLabel(text: String) {
		titleLabel.attributedText = NSAttributedString.title(text: text)
	}
}
