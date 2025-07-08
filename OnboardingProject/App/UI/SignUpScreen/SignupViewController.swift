//
//  SignupViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import Combine
import UIKit

class SignupViewController: SuperViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var signupView: SignupView!
    
    // MARK: - Properties
    private var activeField: UIView?
    private let viewModel = SignupViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardResponsiveScrollView = signupView.scrollView
        signupView.emailTextField.delegate = self
        signupView.usernameTextField.delegate = self
        signupView.passwordTextField.delegate = self
        signupView.confirmPasswordTextField.delegate = self
        bindViewModel()
    }
    
    // MARK: - Actions
    @IBAction
    func signupBtnTapped(_ sender: Any) {
        viewModel.signup(
            email: signupView.email,
            username: signupView.username,
            password: signupView.password,
            confirmPassword: signupView.confirmPassword
        )
    }
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.validationFailure
            .sink { [weak self] error in
                self?.showAlert(
                    title: LocalizationKey.AlertTitle.validationFailed.localized,
                    message: error.localizedDescription
                )
            }
            .store(in: &cancellables)
        
        viewModel.signupSuccess
            .sink { [weak self] message in
                let getInfoVC = GetInfoViewController()
                self?.navigationController?.pushViewController(getInfoVC, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.signupFailure
            .sink { [weak self] errorMessage in
                self?.showAlert(
                    title: LocalizationKey.AlertTitle.signupFailed.localized,
                    message: errorMessage
                )
            }
            .store(in: &cancellables)
    }
}

// MARK: - SignupViewDelegate
extension SignupViewController: SignupViewDelegate {
    
    func didBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func didEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    // MARK: - Actions Methods
    @IBAction
    func googleSignupTapped(_ sender: UIButton) {
        showAlert(
            title: LocalizationKey.AlertTitle.googleSignup.localized,
            message: LocalizationKey.AlertMessage.googleSignup.localized
        )
    }
    
    @IBAction
    func appleSignupTapped(_ sender: UIButton) {
        showAlert(
            title: LocalizationKey.AlertTitle.appleSignup.localized,
            message: LocalizationKey.AlertMessage.appleSignup.localized
        )
    }
    
    @IBAction
    func loginNowButtonTapped(_ sender: Any) {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
}

