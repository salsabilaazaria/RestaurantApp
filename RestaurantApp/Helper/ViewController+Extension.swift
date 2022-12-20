//
//  ViewController+Extension.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 20/12/22.
//

import Foundation
import UIKit

extension UIViewController {
	func useDarkGreenStatusBar() {
		let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
		statusBar.backgroundColor = UIColor.bukaRestoDarkGreen
		UIApplication.shared.keyWindow?.addSubview(statusBar)
	}
	
	func useNavBarWithLeftLogo() {
		useDarkGreenStatusBar()
		navigationController?.navigationBar.backgroundColor = UIColor.bukaRestoDarkGreen
		
		let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
		
		let logoImage = UIImage(named: "logo.png")
		let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
		logoImageView.image = logoImage
		logoImageView.contentMode = .scaleAspectFit

		leftView.addSubview(logoImageView)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
	}
	
}
