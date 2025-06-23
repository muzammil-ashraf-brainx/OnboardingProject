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
    func didTapLoginNow()
}

class SignupView: UIView {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var googleSignupBtn: UIButton!
    @IBOutlet weak var appleSignupBtn: UIButton!
    
    private var isPasswordVisible = false
    private var isConfirmPasswordVisible = false
    weak var delegate: SignupViewDelegate?
    
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
        passwordTextField.configureAsSecureTextField()
        confirmPasswordTextField.configureAsSecureTextField()
        googleSignupBtn?.setupBorderdButton()
        appleSignupBtn?.setupBorderdButton()
    }
    
    // MARK: - Actions Methods
    @IBAction func googleSignupTapped(_ sender: UIButton) {
        delegate?.didTapGoogleSignup()
    }
    
    @IBAction func appleSignupTapped(_ sender: UIButton) {
        delegate?.didTapAppleSignup()
    }
    
    @IBAction func loginNowButtonTapped(_ sender: Any) {
        delegate?.didTapLoginNow()
    }
    
}
