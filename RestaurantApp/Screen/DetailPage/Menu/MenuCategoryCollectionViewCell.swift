//
//  MenuCategoryCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 06/01/23.
//

import UIKit

class MenuCategoryCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var categoryLabel: UILabel!
	let identifier = "MenuCategoryCollectionViewCell"
	
	override func awakeFromNib() {
        super.awakeFromNib()
		backgroundColor = .bukaRestoLightGray
        // Initialization code
    }
	
	func setCategoryLabel(text: String){
		categoryLabel.attributedText = NSAttributedString.body(text: text)
	}

}
