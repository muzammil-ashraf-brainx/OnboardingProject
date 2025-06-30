//
//  ResetPasswordView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import UIKit

class ResetPasswordView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var resetPasswordEmailTextField: UITextField!
    @IBOutlet weak var resetPasswordProceedButton: UIButton!
    @IBOutlet weak var resetPasswordLabel: UILabel!
    
    var registeredEmail: String? {
        return resetPasswordEmailTextField?.text
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIElements()
    }
    
    private func setupUIElements() {
        resetPasswordProceedButton.setCornerRadius(18)
        resetPasswordProceedButton.setBorder(width: 0.5, color: .lightGray)
    }
    
}

