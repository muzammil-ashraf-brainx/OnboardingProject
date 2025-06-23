//
//  OtpSentAlert.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import UIKit

class OtpSentAlert: UIView {
    
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
    var onOk: (() -> Void)?
    
    func configure(withEmail email: String) {
        messageLabel.text = LocalizedStrings.otpSentMessage(with: email)
        backgroundColor = UIColor(named: AppAssets.blackOverlayBackground)
        okButton.setupFilledButton()
    }
    
    @IBAction private func okButtonTapped(_ sender: UIButton) {
        onOk?()
        removeFromSuperview()
    }
    
}

extension OtpSentAlert: NibLoadableView {}
