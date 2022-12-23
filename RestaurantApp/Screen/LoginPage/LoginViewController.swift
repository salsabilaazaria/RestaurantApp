//
//  LoginViewController.swift
//  RestaurantApp
//
//  Created by Maulana Dimas Iffandi on 22/12/22.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var logoImage: UIImageView!

	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var warningEmail: UILabel!
	@IBOutlet weak var warningPassword: UILabel!
	
	@IBOutlet weak var loginButton: UIButton!
	
	private var readyToLogin: Bool = false
	private var emailMatch: Bool = false
	private var passwordMatch: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
		self.view.addGestureRecognizer(tapGestureRecognizer)
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		configureInitialContent()
		configureBackgroundColor()
		configureLogoImage()
		configureLoginButton()
		configureHidePassword()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	
	private func configureInitialContent() {
		warningEmail.text = ""
		warningPassword.text = ""
		
		emailTextField.placeholder = "Email"
		passwordTextField.placeholder = "Password"
	}
	
	private func configureLogoImage() {
		logoImage.image = UIImage(named: "logo")
	}
	
	private func configureBackgroundColor() {
		self.view.backgroundColor = UIColor(red: 0.282, green: 0.51, blue: 0.494, alpha: 1)
	}
	
	private func configureLoginButton() {
		
		loginButton.layer.cornerRadius = 4
		
		guard readyToLogin else {
			configureDisabledButton()
			return
		}
		
		loginButton.tintColor = UIColor.bukaRestoLightGray
		loginButton.isUserInteractionEnabled = true
		loginButton.setAttributedTitle(NSAttributedString.title(text: "Login", color: .bukaRestoDarkGreen), for: .normal)
		loginButton.addTarget(self, action: #selector(configureButtonTapped), for: .touchUpInside)
		loginButton.setNeedsLayout()
		loginButton.layoutIfNeeded()
	}
	
	private func configureDisabledButton() {
		loginButton.isUserInteractionEnabled = false
		loginButton.tintColor = UIColor.bukaRestoDisabledButton
		loginButton.setAttributedTitle(NSAttributedString.title(text: "Login", color: .bukaRestoSecondaryFontColor), for: .normal)
		
	}
	
	@objc private func configureButtonTapped() {
		pushToHomePage()
	}
	
	@objc private func keyboardWillShow(_ notification: NSNotification) {
		guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
		   return
		}
					
		self.view.frame.origin.y = 0 - keyboardSize.height
	}
		
	@objc private func keyboardWillHide(_ notification: NSNotification) {
		self.view.frame.origin.y = 0
	}
	
	@objc func backgroundTap(_ sender: UITapGestureRecognizer) {
		self.view.endEditing(true)
	}
	
	private func validatePassword(password: String) -> Bool{
		let passwordRegex =
		// At least one capital letter
		#"^(?=.*[A-Z])"# +
		
		// At least one lowercase letter
		#"(?=.*[a-z])"# +
		
		// At least one digit
		#"(?=.*\d)"# +
		
		// At least 8 characters
		#".{8,}$"#
		
		let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
		return passwordPred.evaluate(with: password)
	}
	
	func validateEmail(email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}
	
	private func configureWarningPassword() {
		warningPassword.text = "Incorrect Password Format"
		warningPassword.textColor = UIColor.bukaRestoErrorFontColor
	}
	
	private func configureWarningEmail() {
		warningEmail.text = "Incorrect Email Format"
		warningEmail.textColor = UIColor.bukaRestoErrorFontColor
	}
	
	private func configureHidePassword() {
		passwordTextField.isSecureTextEntry = true
	}
}

extension LoginViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		if textField == emailTextField {
			passwordTextField.becomeFirstResponder()
		}
		
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField == emailTextField {
			emailMatch = validateEmail(email: textField.text ?? "")
			if emailMatch {
				warningEmail.text = ""
			} else {
				configureWarningEmail()
			}
		} else if textField == passwordTextField {
			passwordMatch = validatePassword(password: textField.text ?? "")
			if passwordMatch {
				warningPassword.text = ""
			} else {
				configureWarningPassword()
			}
		}
		
		guard emailMatch && passwordMatch else {
			readyToLogin = false
			configureLoginButton()
			return
		}
		
		readyToLogin = true
		configureLoginButton()
	}
}
