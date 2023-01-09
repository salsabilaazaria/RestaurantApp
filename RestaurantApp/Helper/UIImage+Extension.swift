//
//  UIImage+Extension.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 09/01/23.
//

import Foundation
import UIKit

extension UIImage {
 	func getImageFromUrl(url: String) -> UIImage? {
		guard let url = URL(string: url),
			  let data = try? Data(contentsOf: url),
			  let image = UIImage(data: data) else { return nil }
		
		return image
	}
}
