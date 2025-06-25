//
//  OtpVerificationViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

import UIKit

class OtpVerificationViewController: SuperViewController {

    // MARK: - Outlets
    @IBOutlet weak var otpVerificationView: OtpVerificationView!
    @IBOutlet weak var verifyButtonView: UIView!

    private var viewModel: OTPViewModel!
    private var resetURL: String?
    private var email: String!

    func configure(email: String) {
        self.email = email
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OTPViewModel(email: email)
        otpVerificationView.delegate = self
        keyboardResponsiveView = verifyButtonView
        setupBindings()
    }

    // MARK: - ViewModel Bindings
    private func setupBindings() {
        viewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.updateVerifyButtonState()
            }
        }

        viewModel.onSuccess = { [weak self] resetURL in
            DispatchQueue.main.async {
                self?.resetURL = resetURL
                self?.showAlert(
                    title: AppStrings.AlertTitle.success,
                    message: AppStrings.AlertMessage.otpVerified,
                    okAction: {
                        let changePasswordVC: ChangePasswordViewController = .instantiate()
                        changePasswordVC.configure(with: resetURL)
                        self?.navigationController?.pushViewController(changePasswordVC, animated: true)
                    }
                )
            }
        }

        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showAlert(
                    title: AppStrings.AlertTitle.verificationFailed,
                    message: errorMessage
                )
            }
        }
        
        viewModel.onResendSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.showOtpSentAlert(email: self?.email ?? "")
            }
        }


        updateVerifyButtonState()
    }

    private func updateVerifyButtonState() {
        otpVerificationView.verifyButton.isEnabled = viewModel.isValidOTP
    }
    
    private func showOtpSentAlert(email: String) {
        let alertView = OtpSentAlert.instantiate()
        alertView.frame = view.bounds
        alertView.configure(withEmail: email)
        alertView.onOk = {
            alertView.removeFromSuperview()
        }
        view.addSubview(alertView)
    }

}

// MARK: - OtpVerificationViewDelegate
extension OtpVerificationViewController: OtpVerificationViewDelegate {
    func otpTextDidChange(_ code: String) {
        viewModel.otpCode = code
    }

    func resendButtonTapped() {
        viewModel.resendOTP()
    }

    func verifyButtonTapped() {
        viewModel.verifyOTP { _ in }
    }
}

extension OtpVerificationViewController: NibLoadableViewController {}
