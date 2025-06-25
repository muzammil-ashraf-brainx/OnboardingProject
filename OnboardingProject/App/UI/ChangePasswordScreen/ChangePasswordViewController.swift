//
//  ChangePasswordViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 18/06/2025.
//

import UIKit

class ChangePasswordViewController: SuperViewController {

    // MARK: - Outlets
    @IBOutlet var changePasswordView: ChangePasswordView!
    @IBOutlet weak var changePasswordButtonView: UIButton!

    // MARK: - Properties
    private var viewModel: ChangePasswordViewModel!
    private var resetURL: String!

    // MARK: - Configuration
    func configure(with resetURL: String) {
        self.resetURL = resetURL
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChangePasswordViewModel(resetURL: resetURL)
        changePasswordView.delegate = self
        keyboardResponsiveView = changePasswordButtonView
        bindViewModel()
    }

    // MARK: - ViewModel Bindings
    private func bindViewModel() {
        viewModel.onSuccess = { [weak self] message in
            self?.showAlert(
                title: AppStrings.AlertTitle.success,
                message: message,
                okAction: {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            )
        }

        viewModel.onError = { [weak self] error in
            self?.showAlert(
                title: AppStrings.AlertTitle.error,
                message: error
            )
        }
    }
}

// MARK: - ChangePasswordViewDelegate
extension ChangePasswordViewController: ChangePasswordViewDelegate {
    func didTapChangePassword() {
        let password = changePasswordView.password
        let confirmPassword = changePasswordView.confirmPassword

        if let validationError = viewModel.validateFields(password: password, confirmPassword: confirmPassword) {
            showAlert(title: AppStrings.AlertTitle.error, message: validationError)
            return
        }

        viewModel.changePassword(password: password!, confirmPassword: confirmPassword!)
    }
}

// MARK: - NibLoadableViewController
extension ChangePasswordViewController: NibLoadableViewController {}

