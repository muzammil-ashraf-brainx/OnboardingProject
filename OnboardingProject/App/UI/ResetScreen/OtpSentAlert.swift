//
//  OtpSentAlert.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import UIKit

class OtpSentAlert: UIView {
    
    // MARK: - Outlets
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Properties
    var onOk: (() -> Void)?
    
    // MARK: - Setup
    class func instantiate() -> OtpSentAlert {
        let nib = UINib(nibName: "OtpSentAlert", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! OtpSentAlert
    }
    
    func configure(withEmail email: String) {
        messageLabel.text = """
        We have sent a verification code to your email \(email). If you don't see it in your inbox, please make sure to also check your junk/spam folder.
        """
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        okButton.setupButton()
    }
    
    // MARK: - Actions
    @IBAction private func okButtonTapped(_ sender: UIButton) {
        onOk?()
        removeFromSuperview()
    }
    
}

