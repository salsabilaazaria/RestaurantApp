//
//  TopSearchCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 28/12/22.
//

import UIKit

class TopSearchCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var topSearchLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		backgroundColor = .white
		layer.cornerRadius = 4.0
        // Initialization code
    }
	
	func setTopSearchLabel(text: String){
		topSearchLabel.attributedText = NSAttributedString.body(text: text)
	}

}
