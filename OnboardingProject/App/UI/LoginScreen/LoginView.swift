//
//  LoginView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import UIKit

// MARK: - Delegate Protocol
protocol LoginViewDelegate: AnyObject {
    func didTapLogin()
    func didTapForgetPassword()
    func didTapCreateAccount()
}

// MARK: - LoginView
class LoginView: UIView {
    
    // MARK: - Outlets
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var forgetPasswordButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var isPasswordVisible = false
    weak var delegate: LoginViewDelegate?
    
    var username: String? { usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) }
    var password: String? { passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIElements()
    }
    
    // MARK: - UI Setup
    private func setupUIElements() {
        usernameTextField.autocapitalizationType = .none
        usernameTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        passwordTextField.configureAsSecureTextField()
        loginButton.setupFilledButton()
        forgetPasswordButton.setTitleColor(.systemBrown, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        delegate?.didTapLogin()
    }
    
    @IBAction private func forgetPasswordTapped(_ sender: UIButton) {
        delegate?.didTapForgetPassword()
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        delegate?.didTapCreateAccount()
    }
    
}



