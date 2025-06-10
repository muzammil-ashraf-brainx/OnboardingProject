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
    
    // MARK: - Constants
    private enum UIConstants {
        static let cornerRadius: CGFloat = 20
        static let borderWidth: CGFloat = 2
        static let containerWidth: CGFloat = 40
        static let eyeButtonSize: CGFloat = 30
        static let eyeButtonOffset: CGFloat = 5
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        addPasswordToggle(to: passwordTextField, isVisible: isPasswordVisible, selector: #selector(togglePasswordVisibility))
        addPasswordToggle(to: confirmPasswordTextField, isVisible: isConfirmPasswordVisible, selector: #selector(toggleConfirmPasswordVisibility))
        
        let buttons: [UIButton?] = [googleSignupBtn, appleSignupBtn]
        buttons.forEach { button in
            guard let button = button else { return }
            button.layer.cornerRadius = UIConstants.cornerRadius
            button.layer.borderWidth = UIConstants.borderWidth
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.masksToBounds = true
        }
    }
    
    // MARK: - Password Toggle Icon Setup
    private func addPasswordToggle(to textField: UITextField, isVisible: Bool, selector: Selector) {
        let eyeButton = UIButton(type: .custom)
        let imageName = isVisible ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 0, y: 0, width: UIConstants.eyeButtonSize, height: UIConstants.eyeButtonSize)
        eyeButton.contentMode = .scaleAspectFit
        eyeButton.addTarget(self, action: selector, for: .touchUpInside)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIConstants.containerWidth, height: UIConstants.eyeButtonSize))
        eyeButton.center = CGPoint(x: UIConstants.containerWidth / 2 - UIConstants.eyeButtonOffset, y: UIConstants.eyeButtonSize / 2)
        containerView.addSubview(eyeButton)
        
        textField.rightView = containerView
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
    }
    
    // MARK: - Toggle Actions
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        guard let container = passwordTextField.rightView,
              let button = container.subviews.first as? UIButton else { return }
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        button.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func toggleConfirmPasswordVisibility() {
        isConfirmPasswordVisible.toggle()
        confirmPasswordTextField.isSecureTextEntry = !isConfirmPasswordVisible
        guard let container = confirmPasswordTextField.rightView,
              let button = container.subviews.first as? UIButton else { return }
        let imageName = isConfirmPasswordVisible ? "eye" : "eye.slash"
        button.setImage(UIImage(systemName: imageName), for: .normal)
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
