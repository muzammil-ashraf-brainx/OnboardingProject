//
//  OtpVerificationViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

import Combine
import UIKit

class OtpVerificationViewController: SuperViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var otpVerificationView: OtpVerificationView!
    
    // MARK: - Properties
    private var viewModel: OTPViewModel!
    private var resetURL: String?
    private var email: String!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Configure
    func configure(email: String) {
        self.email = email
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OTPViewModel(email: email)
        otpVerificationView.delegate = self
        keyboardResponsiveView = otpVerificationView.verifyButtonContainerView
        setupBindings()
    }
    
    // MARK: - ViewModel Bindings
    private func setupBindings() {
        viewModel.updateUI
            .sink { [weak self] in
                self?.updateVerifyButtonState()
            }
            .store(in: &cancellables)
        
        viewModel.success
            .sink { [weak self] resetURL in
                self?.resetURL = resetURL
                self?.showAlert(
                    title: LocalizationKey.AlertTitle.success.localized,
                    message: LocalizationKey.AlertMessage.otpVerified.localized,
                    okAction: {
                        let changePasswordVC = ChangePasswordViewController()
                        self?.navigationController?.pushViewController(changePasswordVC, animated: true)
                    }
                )
            }
            .store(in: &cancellables)
        
        viewModel.error
            .sink { [weak self] message in
                self?.showAlert(
                    title: LocalizationKey.AlertTitle.verificationFailed.localized,
                    message: message
                )
            }
            .store(in: &cancellables)
        
        viewModel.resendSuccess
            .sink { [weak self] in
                self?.navigateToOtpSentAlert(email: self?.email ?? "")
            }
            .store(in: &cancellables)
        
        updateVerifyButtonState()
    }
    
    private func updateVerifyButtonState() {
        otpVerificationView.verifyButton.isEnabled = viewModel.isValidOTP
    }
    
    // MARK: - Navigation
    private func navigateToOtpSentAlert(email: String) {
        let alertVC =  OtpSentAlertViewController()
        alertVC.configure(email: email)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    // MARK: - Actions
    @IBAction
    func resendButtonTapped(_ sender: UIButton) {
        viewModel.resendOTP()
    }
    
    @IBAction
    func verifyButtonTapped(_ sender: UIButton) {
        viewModel.verifyOTP()
    }
}

// MARK: - OtpVerificationViewDelegate
extension OtpVerificationViewController: OtpVerificationViewDelegate {
    
    func otpTextDidChange(_ code: String) {
        viewModel.otpCode = code
    }
}

