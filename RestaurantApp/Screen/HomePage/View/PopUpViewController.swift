//
//  PopUpViewController.swift
//  RestaurantApp
//
//  Created by Salsabila Azaria on 26/12/22.
//

import UIKit

class PopUpViewController: UIViewController {

	@IBOutlet weak var dismissTapArea: UIView!
	@IBOutlet weak var popUpContainer: UIView!
	@IBOutlet weak var popUpLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor(red: 79/255.0, green: 79/255.0, blue: 79/255.0, alpha: 0.5)
		self.popUpContainer.layer.cornerRadius = 8.0

		
		configureLabelPopUp()
		configureTapGesture() 
    }

	private func configureLabelPopUp() {
		popUpLabel.attributedText = NSAttributedString.title(text: "Under Maintenance", color: .bukaRestoDarkGreen)
	}
	
	private func configureTapGesture() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(exitPopUp))
		self.dismissTapArea.addGestureRecognizer(tapGestureRecognizer)
	}
	
	@objc func exitPopUp(_ sender: UITapGestureRecognizer) {
		self.dismiss(animated: false, completion: nil)
	}
	
}
