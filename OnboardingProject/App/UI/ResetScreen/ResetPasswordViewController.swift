//
//  ResetPasswordViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import UIKit

class ResetPasswordViewController: SuperViewController {
    
    @IBOutlet weak var proceedButtonView: UIView!
    @IBOutlet var resetPasswordView: ResetPasswordView!
    
    private let viewModel = ResetPasswordViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardResponsiveView = proceedButtonView
        resetPasswordView.delegate = self
    }
    
    private func showOtpSentAlert(email: String) {
        let alertView = OtpSentAlert.instantiate()
        alertView.frame = view.bounds
        alertView.configure(withEmail: email)
        
        alertView.onOk = { [weak self] in
            let otpVC: OtpVerificationViewController = .instantiate()
            otpVC.configure(email: email)
            self?.navigationController?.pushViewController(otpVC, animated: true)
        }
        
        view.addSubview(alertView)
    }
    
}

// MARK: - ResetPasswordViewDelegate
extension ResetPasswordViewController: ResetPasswordViewDelegate {
    func didTapResetPasswordProceedButton() {
        guard let email = resetPasswordView.registeredEmail else { return }

        viewModel.onResetSuccess = { [weak self] verifiedEmail in
            self?.showOtpSentAlert(email: verifiedEmail)
        }

        viewModel.onResetFailure = { [weak self] errorMessage in
            self?.showAlert(title: AppStrings.AlertTitle.error, message: errorMessage)
        }

        viewModel.resetPassword(email: email)
    }
    
}

extension ResetPasswordViewController: NibLoadableViewController {}
