//
//  MenuCategoryCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 06/01/23.
//

import UIKit

class MenuCategoryCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var labelContainer: UIView!
	@IBOutlet weak var categoryLabel: UILabel!
	let identifier = "MenuCategoryCollectionViewCell"
	
	override func awakeFromNib() {
        super.awakeFromNib()
		labelContainer.layer.borderColor = UIColor.bukaRestoDarkGreen.cgColor
		labelContainer.layer.borderWidth = 1.0
		labelContainer.layer.cornerRadius = 4.0
    }
	
	func setCategoryLabel(text: String){
		categoryLabel.attributedText = NSAttributedString.body(text: text)
	}

}
