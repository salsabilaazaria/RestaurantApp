//
//  HomePageViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 20/12/22.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		configureHomeNavBar()
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
}
