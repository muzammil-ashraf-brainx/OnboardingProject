//
//  SignupViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SignupViewController: SuperViewController {
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signupView: SignupView!
    
    // MARK: - Properties
    private var activeField: UIView?
    private let viewModel = SignupViewModel()
    override var shouldHandleKeyboardInternally: Bool { false }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signupView.emailTextField.delegate = self
        signupView.usernameTextField.delegate = self
        signupView.passwordTextField.delegate = self
        signupView.confirmPasswordTextField.delegate = self
        registerForKeyboardNotifications()
        setupDismissKeyboardGesture()
        bindViewModel()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    @IBAction func signupBtnTapped(_ sender: Any) {
        if let errorMessage = viewModel.validateSignupFields(
            email: signupView.email,
            username: signupView.username,
            password: signupView.password,
            confirmPassword: signupView.confirmPassword
        ) {
            showAlert(title: AppStrings.AlertTitle.validationFailed, message: errorMessage)
            return
        }
        
        viewModel.signup(
            email: signupView.email!,
            username: signupView.username!,
            password: signupView.password!
        )
    }
    
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
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        let keyboardHeight = keyboardFrame.height
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        
        if let activeField = activeField {
            var fieldFrame = scrollView.convert(activeField.frame, from: activeField.superview)
            fieldFrame.size.height += 60
            scrollView.scrollRectToVisible(fieldFrame, animated: true)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func bindViewModel() {
        viewModel.onSignupSuccess = { [weak self] message in
            let getInfoVC: GetInfoViewController = .instantiate()
            self?.navigationController?.pushViewController(getInfoVC, animated: true)
        }
        
        viewModel.onSignupFailure = { [weak self] errorMessage in
            self?.showAlert(
                title: AppStrings.AlertTitle.signupFailed,
                message: errorMessage
            )
        }
    }
    
}

// MARK: - Extensions
extension SignupViewController: SignupViewDelegate {
    func didTapLoginNow() {
        let loginVC: LoginViewController = .instantiate()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func didBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func didEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func didTapGoogleSignup() {
        // TODO: Implement Google Sign-In using appropriate SDK
        let alert = UIAlertController(
            title: AppStrings.AlertTitle.googleSignup,
            message: AppStrings.AlertMessage.googleSignup,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: AppStrings.AlertButton.ok, style: .default))
        present(alert, animated: true)
    }
    
    func didTapAppleSignup() {
        // TODO: Implement Apple Sign-In using appropriate SDK
        let alert = UIAlertController(
            title: AppStrings.AlertTitle.appleSignup,
            message: AppStrings.AlertMessage.appleSignup,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: AppStrings.AlertButton.ok, style: .default))
        present(alert, animated: true)
    }
    
}

extension SignupViewController: NibLoadableViewController {}

extension SignupViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
}

