//
//  LocationManager.swift
//  RestaurantApp
//
//  Created by Maulana Dimas Iffandi on 29/12/22.
//

import Foundation
import CoreLocation

extension NSNotification.Name {
	static let sharedLocation = NSNotification.Name("sharedLocation")
}

class LocationManager: NSObject, CLLocationManagerDelegate {
	
	static let shared = LocationManager()
	let manager = CLLocationManager()
	
	private let notificationCenter = NotificationCenter.default
	
	var lat: Double = 0.0
	var long: Double = 0.0
	
	private override init() {
		
	}
	
	func checkLocationService() {
		if CLLocationManager.locationServicesEnabled() {
			setupLocationManager()
			checkLocationManagerAuthorization()
		} else {
			setupNotificationCenter(object: ["error": true])
		}
	}
	
	func setupLocationManager() {
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.distanceFilter = 500
	}
	
	func checkLocationManagerAuthorization() {
		switch authorizationStatus() {
		case .notDetermined:
			print("Auth: notDetermined")
			manager.requestWhenInUseAuthorization()
		case .authorizedAlways, .authorizedWhenInUse:
			print("Auth: authorizedWhenInUse")
			manager.startUpdatingLocation()
		case .denied, .restricted:
			print("Auth: denied")
			setupNotificationCenter(object: ["error": true])
			break
		default:
			setupNotificationCenter(object: ["error": true])
			break
		}
	}
	
	func authorizationStatus() -> CLAuthorizationStatus {
		var status: CLAuthorizationStatus
		if #available(iOS 14.0, *) {
			status = CLLocationManager().authorizationStatus
		} else {
			status = CLLocationManager.authorizationStatus()
		}
		return status
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let object: [String: Any] = [
				"error": false,
				"location": location
			]
			
			lat = (location.coordinate.latitude)
			long = (location.coordinate.longitude)
			
			DispatchQueue.main.async {
				self.setupNotificationCenter(object: object)
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		checkLocationService()
	}
		
	func setupNotificationCenter(object: Any? = nil) {
		notificationCenter.post(name: .sharedLocation, object: object)
	}
}
