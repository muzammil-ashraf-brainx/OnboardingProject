//
//  LoginViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var loginView: LoginView!
    @IBOutlet private weak var formContainerView: UIView!
    
    // MARK: - Properties
    private let viewModel = LoginViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        registerForKeyboardNotifications()
        setupDismissKeyboardGesture()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Keyboard Handling
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurve << 16)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [animationOptions, .beginFromCurrentState]) {
            self.formContainerView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + self.view.safeAreaInsets.bottom)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurve << 16)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [animationOptions, .beginFromCurrentState]) {
            self.formContainerView.transform = .identity
        }
    }
    
    // MARK: - Dismiss Keyboard
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    
    func didTapCreateAccount() {
        let signupVC: SignupViewController = .instantiate()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    func didTapLogin() {
        viewModel.login(
            username: loginView.username,
            password: loginView.password
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let getInfoVC: GetInfoViewController = .instantiate()
                    self?.navigationController?.pushViewController(getInfoVC, animated: true)
                case .failure(let error):
                    let alert = UIAlertController(
                        title: AppStrings.AlertTitle.loginFailed,
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: AppStrings.AlertButton.ok, style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    func didTapForgetPassword() {
        let alert = UIAlertController(
            title: AppStrings.AlertTitle.forgotPassword,
            message: AppStrings.AlertMessage.forgotPassword,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: AppStrings.AlertButton.ok, style: .default))
        present(alert, animated: true)
    }
    
}

// MARK: - NibLoadableViewController
extension LoginViewController: NibLoadableViewController {}
