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
}

class SignupView: UIView {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var googleSignupBtn: UIButton!
    @IBOutlet weak var appleSignupBtn: UIButton!
    @IBOutlet private(set) weak var scrollView: UIScrollView!
    
    
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
        googleSignupBtn?.setCornerRadius(18)
        googleSignupBtn.setBorder(width: 0.5, color: .lightGray)
        appleSignupBtn?.setCornerRadius(18)
        appleSignupBtn?.setBorder(width: 0.5, color: .lightGray)
        
    }
}
