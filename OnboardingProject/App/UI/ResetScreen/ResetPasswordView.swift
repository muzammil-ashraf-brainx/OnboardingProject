//
//  ResetPasswordView.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import UIKit

protocol ResetPasswordViewDelegate: AnyObject {
    func didTapResetPasswordProceedButton()
    
}

class ResetPasswordView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var resetPasswordEmailTextField: UITextField!
    @IBOutlet weak var resetPasswordProceedButton: UIButton!
    @IBOutlet weak var resetPasswordLabel: UILabel!
    
    weak var delegate: ResetPasswordViewDelegate?
    
    var registeredEmail: String? {
        return resetPasswordEmailTextField?.text
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIElements()
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: Any) {
        delegate?.didTapResetPasswordProceedButton()
    }
    
    private func setupUIElements() {
        resetPasswordProceedButton?.setupFilledButton()
    }
    
}

