//
//  LoginView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import UIKit



// MARK: - LoginView
class LoginView: UIView {
    
    // MARK: - Outlets
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var forgetPasswordButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    var username: String? { userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) }
    var password: String? { passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIElements()
    }
    
    // MARK: - UI Setup
    private func setupUIElements() {
        userNameTextField.autocapitalizationType = .none
        userNameTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        passwordTextField.configureAsSecureTextField()
        loginButton?.setCornerRadius(18)
        loginButton?.setBorder(width: 0.5, color: .lightGray)
        forgetPasswordButton.setTitleColor(.systemBrown, for: .normal)
    }
    
}



