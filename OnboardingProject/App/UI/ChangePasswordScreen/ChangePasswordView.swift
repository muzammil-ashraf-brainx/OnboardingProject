//
//  ChangePasswordView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 24/06/2025.
//

import UIKit

// MARK: - Delegate Protocol
protocol ChangePasswordViewDelegate: AnyObject {
    func didTapChangePassword()
}
class ChangePasswordView: UIView {
    
    @IBOutlet weak var createNewPasswordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cofirmPasswordTextField: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    private var isPasswordVisible = false
    private var isConfirmPasswordVisible = false
    
    weak var delegate:  ChangePasswordViewDelegate?
    
    var password: String? {passwordTextField.text}
    var confirmPassword: String? {cofirmPasswordTextField.text}
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
        changePasswordButton.setupFilledButton()
        passwordTextField.configureAsSecureTextField()
        cofirmPasswordTextField.configureAsSecureTextField()

    }
    
    @IBAction func changePasswordButtonTapped(_ sender: Any) {
        delegate?.didTapChangePassword()
    }
}
