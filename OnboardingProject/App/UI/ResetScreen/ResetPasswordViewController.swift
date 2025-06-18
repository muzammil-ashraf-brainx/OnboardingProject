//
//  ResetPasswordViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var ProceedButtonView: UIView!
    @IBOutlet var resetPasswordView: ResetPasswordView!
    
    // MARK: - Properties
    private let viewModel = ResetPasswordViewModel()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.delegate = self
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
            self.ProceedButtonView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + self.view.safeAreaInsets.bottom)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        let animationOptions = UIView.AnimationOptions(rawValue: animationCurve << 16)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [animationOptions, .beginFromCurrentState]) {
            self.ProceedButtonView.transform = .identity
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
    
    // MARK: - Show Custom Alert
    private func showOtpSentAlert(email: String) {
        let alertView = OtpSentAlert.instantiate()
        alertView.frame = view.bounds
        alertView.configure(withEmail: email)
        
        alertView.onOk = { [weak self] in
            guard let self = self else { return }
            
            let otpVC = OtpVerificationViewController(
                nibName: "OtpVerificationViewController",
                bundle: nil
            )
            
            otpVC.userEmail = email 
            self.navigationController?.pushViewController(otpVC, animated: true)
        }
        
        view.addSubview(alertView)
    }
    
}

// MARK: - Delegate
extension ResetPasswordViewController: ResetPasswordViewDelegate {
    func didTapResetPasswordProceedButton() {
        guard let email = resetPasswordView.registeredEmail else { return }
        
        viewModel.resetPassword(email: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.showOtpSentAlert(email: email)
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
}

