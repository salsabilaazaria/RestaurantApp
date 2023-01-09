//
//  MenuTableViewCell.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 04/01/23.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
	
	let identifier = "MenuTableViewCell"
	
	@IBOutlet weak var menuImage: UIImageView!
	@IBOutlet weak var menuName: UILabel!
	@IBOutlet weak var menuDesc: UILabel!
	@IBOutlet weak var tagView: UIView!
	@IBOutlet weak var menuPrice: UILabel!
	
	var menu: Menu? = nil {
		didSet {
			DispatchQueue.main.async {
				self.configureCell()
				self.layoutIfNeeded()
//				self.setNeedsLayout()
			}
		}
	}

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
	
	private func configureCell() {
		configureImage()
		configureName()
		configureDesc()
		configurePrice()
	}
	
	private func configureImage() {
		guard let image = UIImage().getImageFromUrl(url: self.menu?.image_url ?? "") else {
			menuImage.isHidden = true
			return
		}
		menuImage.image = image
		menuImage.contentMode = .scaleAspectFit
	}
	
	private func configureName() {
		guard let name = menu?.name else {
			menuName.isHidden = true
			return
		}
		menuName.attributedText = NSAttributedString.body(text: name)
	}
	
	private func configureDesc() {
		guard let desc = menu?.description else {
			menuDesc.isHidden = true
			return
		}
		menuDesc.attributedText = NSAttributedString.body(text: desc)
	}
	
	private func configurePrice() {
		guard let price = menu?.price else {
			menuPrice.isHidden = true
			return
		}
		
		menuPrice.attributedText = NSAttributedString.rupiahFormat(number: price)
	}
	
    
}
