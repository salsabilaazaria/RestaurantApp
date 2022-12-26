//
//  TopRestoFooterCollectionReusableView.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 26/12/22.
//

import UIKit

class TopRestoFooterCollectionReusableView: UICollectionReusableView {

	@IBOutlet weak var footerLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func configureFooterLabel(text: String) {
		footerLabel.attributedText = NSAttributedString.body(text: text, color: .bukaRestoDarkGreen)
	}
    
}
