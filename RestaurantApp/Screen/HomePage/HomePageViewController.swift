//
//  HomePageViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 20/12/22.
//

import UIKit

class HomePageViewController: UIViewController {

	@IBOutlet weak var titleTopResto: UILabel!
	@IBOutlet weak var firstNumberText: UILabel!
	@IBOutlet weak var secondNumberText: UILabel!
	@IBOutlet weak var thirdNumberText: UILabel!

	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.bukaRestoLightGray
        super.viewDidLoad()
		configureHomeNavBar()
		configureTitleTopResto()
		configureNumberText()
    }
	
	private func configureHomeNavBar() {
		useNavBarWithLeftLogo()
		
		let settingButton = UIButton(type: .custom)
		settingButton.setImage(UIImage(named: "setting-icon.png"), for: .normal)
		let scanButton = UIButton(type: .custom)
		scanButton.setImage(UIImage(named: "scan-icon.png"), for: .normal)
		let searchButton = UIButton(type: .custom)
		searchButton.setImage(UIImage(named: "search-icon.png"), for: .normal)
		
		navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: settingButton),
											  UIBarButtonItem(customView: scanButton),
											  UIBarButtonItem(customView: searchButton)]
	}
	
	private func configureTitleTopResto() {
		titleTopResto.attributedText = NSAttributedString.title(text: "Top Resto")
	}
	
	private func configureNumberText() {
		firstNumberText.attributedText = NSAttributedString.title(text: "1")
		secondNumberText.attributedText = NSAttributedString.title(text: "2")
		thirdNumberText.attributedText = NSAttributedString.title(text: "3")
	}
	
}
