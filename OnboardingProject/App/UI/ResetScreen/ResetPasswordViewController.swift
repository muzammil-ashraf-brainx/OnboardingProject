//
//  ResetPasswordViewController 2.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 30/06/2025.
//

import Combine
import UIKit

class ResetPasswordViewController: SuperViewController {
    
    // MARK: - IBOutlets 
    @IBOutlet var resetPasswordView: ResetPasswordView!
    
    private let viewModel = ResetPasswordViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardResponsiveView = resetPasswordView .proceedButtonContainerView
        bindViewModel()
    }
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.resetSuccess
            .sink { [weak self] verifiedEmail in
                self?.showOtpSentAlert(email: verifiedEmail)
            }
            .store(in: &cancellables)
        
        viewModel.resetFailure
            .sink { [weak self] errorMessage in
                self?.showAlert(
                    title: LocalizationKey.AlertTitle.error.localized,
                    message: errorMessage
                )
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Navigation
    private func showOtpSentAlert(email: String) {
        let alertVC =  OtpSentAlertViewController()
        alertVC.configure(email: email)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    // MARK: - Actions
    @IBAction
    func resetPasswordButtonTapped(_ sender: Any) {
        guard let email = resetPasswordView.registeredEmail else { return }
        viewModel.resetPassword(email: email)
    }
}

