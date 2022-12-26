//
//  AppDelegate.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 12/12/22.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		setupInitialScreen()
		FirebaseApp.configure()
		
		return true
	}

	private func setupInitialScreen() {
		let initialVC = HomePageViewController()
		let navVC = UINavigationController(rootViewController: initialVC)
		
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = navVC
		window.makeKeyAndVisible()
		
		self.window = window
	}


}

