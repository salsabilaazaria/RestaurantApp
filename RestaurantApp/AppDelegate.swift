//
//  AppDelegate.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 12/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		setupInitialScreen()
		
		return true
	}

	private func setupInitialScreen() {
		let initialVC = LoginViewController()
		let navVC = UINavigationController(rootViewController: initialVC)
		
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = navVC
		window.makeKeyAndVisible()
		
		self.window = window
	}


}
