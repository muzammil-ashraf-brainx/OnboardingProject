//
//  SignupView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//
import UIKit

// MARK: - Delegate Protocol
protocol SignupViewDelegate: AnyObject {
    func didBeginEditing(_ textField: UITextField)
    func didEndEditing(_ textField: UITextField)
    func didTapGoogleSignup()
    func didTapAppleSignup()
}

class SignupView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var googleSignupBtn: UIButton!
    @IBOutlet weak var appleSignupBtn: UIButton!
    
    // MARK: - Properties
    private var isPasswordVisible = false
    private var isConfirmPasswordVisible = false
    weak var delegate: SignupViewDelegate?
    
    // MARK: - Public Accessors
    var email: String? { emailTextField.text }
    var username: String? { usernameTextField.text }
    var password: String? { passwordTextField.text }
    var confirmPassword: String? { confirmPasswordTextField.text }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIElements()
    }
    
    // MARK: - UI Setup
    private func setupUIElements() {
        passwordTextField.addPasswordToggle(
            isVisible: isPasswordVisible,
            target: self,
            action: #selector(togglePasswordVisibility)
        )
        
        confirmPasswordTextField.addPasswordToggle(
            isVisible: isConfirmPasswordVisible,
            target: self,
            action: #selector(toggleConfirmPasswordVisibility)
        )
        
        googleSignupBtn?.setupButton()
        appleSignupBtn?.setupButton()
    }
    
    // MARK: - Toggle Actions
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        passwordTextField.updateEyeIcon(isVisible: isPasswordVisible)
    }
    
    @objc private func toggleConfirmPasswordVisibility() {
        isConfirmPasswordVisible.toggle()
        confirmPasswordTextField.isSecureTextEntry = !isConfirmPasswordVisible
        confirmPasswordTextField.updateEyeIcon(isVisible: isConfirmPasswordVisible)
    }
    
    // MARK: - Actions
    @IBAction func googleSignupTapped(_ sender: UIButton) {
        delegate?.didTapGoogleSignup()
    }
    
    @IBAction func appleSignupTapped(_ sender: UIButton) {
        delegate?.didTapAppleSignup()
    }
    
    // MARK: - Delegation Setup
    func setupDelegates(_ delegate: SignupViewDelegate) {
        self.delegate = delegate
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
}

// MARK: - UITextFieldDelegate
extension SignupView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(textField)
    }
    
}

