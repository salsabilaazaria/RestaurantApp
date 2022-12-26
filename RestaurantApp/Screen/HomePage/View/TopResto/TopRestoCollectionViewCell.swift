//
//  TopRestoCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 23/12/22.
//

import UIKit


class TopRestoCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var restoNameLabel: UILabel!
	@IBOutlet weak var numberLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func configureTopRestoLabel(number: String, restoName: String) {
		numberLabel.attributedText = NSAttributedString.title(text: number)
		restoNameLabel.attributedText = NSAttributedString.body(text: restoName)
	}

}
