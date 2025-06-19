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
    
    // MARK: - Properties
    private var isPasswordVisible = false
    weak var delegate: LoginViewDelegate?
    
    // MARK: - Public Accessors
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
        passwordTextField.addPasswordToggle(
            isVisible: isPasswordVisible,
            target: self,
            action: #selector(togglePasswordVisibility)
        )
        
        loginButton.setupButton()
        forgetPasswordButton.setTitleColor(.systemBrown, for: .normal)
    }

    // MARK: - Toggle Password Visibility
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        passwordTextField.updateEyeIcon(isVisible: isPasswordVisible)
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



