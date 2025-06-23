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
    @IBOutlet private weak var formContainerView: UIView!
    
    // MARK: - Properties
    private let viewModel = LoginViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        keyboardResponsiveView = formContainerView
        bindViewModel()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.onLoginSuccess = { [weak self] in
            self?.navigateToGetInfoScreen()
        }
        
        viewModel.onLoginFailure = { [weak self] errorMessage in
            self?.showAlert(
                title: AppStrings.AlertTitle.loginFailed,
                message: errorMessage
            )
        }
        
        viewModel.onValidationFailed = { [weak self] validationMessage in
            self?.showAlert(
                title: AppStrings.AlertTitle.validationFailed,
                message: validationMessage
            )
        }
        
    }
    
    private func navigateToGetInfoScreen() {
        let getInfoVC: GetInfoViewController = .instantiate()
        navigationController?.pushViewController(getInfoVC, animated: true)
    }
    
}

// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func didTapCreateAccount() {
        let signupVC: SignupViewController = .instantiate()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    func didTapLogin() {
        viewModel.login(username: loginView.username, password: loginView.password)
    }
    
    func didTapForgetPassword() {
        let resetPasswordVC: ResetPasswordViewController = .instantiate()
        navigationController?.pushViewController(resetPasswordVC, animated: true)
    }

    
}

extension LoginViewController: NibLoadableViewController {}

