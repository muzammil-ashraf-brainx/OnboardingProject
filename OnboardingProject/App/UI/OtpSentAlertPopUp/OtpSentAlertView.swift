//
//  OtpSentAlert.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import UIKit

class OtpSentAlertView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var okButton: UIButton!
    
    // MARK: - Properties
    var onOk: (() -> Void)?
    
    // MARK: - Setup
    func configure(withEmail email: String?) {
        setupUI()
        messageLabel.text = String(format: LocalizationKey.OTP.sentMessage.localized, email ?? "")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(resource: .blackOverlay)
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        
        okButton.setCornerRadius(18)
        okButton.setBorder(width: 0.5, color: .lightGray)
    }
    
    // MARK: - Actions
    @IBAction private func okButtonTapped(_ sender: UIButton) {
        onOk?()
    }
    
}

