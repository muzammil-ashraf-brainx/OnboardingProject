//
//  SignupView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SignupView: UIView {
    
    // MARK: - Outlets

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var googleSignupBtn: UIButton!
    @IBOutlet weak var appleSignupBtn: UIButton!
    
    // MARK: - Properties

    private var isPasswordVisible = false
    private var isConfirmPasswordVisible = false

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
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 2
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
        eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        eyeButton.contentMode = .scaleAspectFit
        eyeButton.addTarget(self, action: selector, for: .touchUpInside)

        let containerWidth: CGFloat = 40
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: 30))
        eyeButton.center = CGPoint(x: containerWidth / 2 - 5, y: 15)
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
    
}

