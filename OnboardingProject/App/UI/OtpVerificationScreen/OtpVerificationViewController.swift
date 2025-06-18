//
//  OtpVerificationViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

import UIKit

class OtpVerificationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var otpVerificationView: OtpVerificationView!
    @IBOutlet weak var verifyButtonView: UIView!
    
    // MARK: - Properties
    private var viewModel = OTPViewModel()
    public var userEmail = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        setupDismissKeyboardGesture()
        setup()
        otpVerificationView.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    private func setup() {
        // Configure ViewModel
        viewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        viewModel.onSuccess = { [weak self] in
            self?.handleOTPVerificationSuccess()
        }

        viewModel.onError = { [weak self] errorMessage in
            self?.showErrorAlert(message: errorMessage)
        }
        
        // Initial UI update
        updateUI()
    }
    
    private func updateUI() {
        otpVerificationView.verifyButton.isEnabled = viewModel.isValidOTP
    }
    
    private func handleOTPVerificationSuccess() {
        // Proceed to next screen or show success message
        showSuccessAlert(message: "OTP verified successfully.")
    }
    
    private func showSuccessAlert(message: String) {
        let alert = UIAlertController(
            title: "Success",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            // Optional: Navigate to next screen after success
        })
        present(alert, animated: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Verification Failed",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
            self.verifyButtonView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + self.view.safeAreaInsets.bottom)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurve << 16)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [animationOptions, .beginFromCurrentState]) {
            self.verifyButtonView.transform = .identity
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

//MARK: - OtpVerificationViewDelegate
extension OtpVerificationViewController: OtpVerificationViewDelegate {
    func otpTextDidChange(_ code: String) {
        viewModel.otpCode = code
    }
    
    func resendButtonTapped() {
        viewModel.resendOTP()
    }
    
    func verifyButtonTapped() {
        viewModel.verifyOTP(email: userEmail) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    let alert = UIAlertController(
                        title: "Success",
                        message: "OTP verified successfully.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        
                        let changePasswordVC = ChangePasswordViewController()
                        self?.navigationController?.pushViewController(changePasswordVC, animated: true)
                    })
                    self?.present(alert, animated: true)

                case .failure(let error):
                    let alert = UIAlertController(
                        title: "Verification Failed",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

