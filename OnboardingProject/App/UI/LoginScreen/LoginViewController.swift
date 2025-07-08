//
//  LoginViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import UIKit

class LoginViewController: SuperViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var loginView: LoginView!
    
    // MARK: - Properties
    private let viewModel = LoginViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardResponsiveView = loginView.formContainerView
        bindViewModel()
    }
    
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.onLoginSuccess = { [weak self] in
            self?.navigateToGetInfoScreen()
        }
        
        viewModel.onLoginFailure = { [weak self] errorMessage in
            self?.showAlert(
                title: LocalizationKey.AlertTitle.loginFailed.localized,
                message: errorMessage
            )
        }
        
        viewModel.onValidationFailed = { [weak self] validationMessage in
            self?.showAlert(
                title: LocalizationKey.AlertTitle.validationFailed.localized,
                message: validationMessage
            )
        }
        
    }
    
    private func navigateToGetInfoScreen() {
        let getInfoVC = GetInfoViewController()
        navigationController?.pushViewController(getInfoVC, animated: true)
    }
    
    // MARK: - Actions
    @IBAction
    private func loginButtonTapped(_ sender: UIButton) {
        viewModel.login(username: loginView.username, password: loginView.password)
    }
    
    @IBAction
    private func forgetPasswordTapped(_ sender: UIButton) {
        let resetPasswordVC = ResetPasswordViewController()
        navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    @IBAction
    func createAccountButtonTapped(_ sender: Any) {
        let signupVC = SignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
}

