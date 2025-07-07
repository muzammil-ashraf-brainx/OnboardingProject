//
//  OtpSentAlertViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 27/06/2025.
//

import UIKit

class OtpSentAlertViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet var otpSentAlertView: OtpSentAlertView!
    
    private var email: String = .empty
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Configuration
    func configure(email: String) {
        self.email = email
    }
    
    private func configureView() {
        otpSentAlertView.configure(withEmail: email)
        
        otpSentAlertView.onOk = { [weak self] in
            self?.navigateToOtpVerification()
        }
    }
    
    @IBAction private func okButtonTapped(_ sender: UIButton) {
        otpSentAlertView.onOk?()
    }
    
    private func navigateToOtpVerification() {
        let otpVC = OtpVerificationViewController()
        otpVC.configure(email: email)
        
        if let navigationController = presentingViewController as? UINavigationController {
            dismiss(animated: true) {
                navigationController.pushViewController(otpVC, animated: true)
            }
        } else {
            navigationController?.pushViewController(otpVC, animated: true)
        }
    }
}

