//
//  SuperViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 20/06/2025.
//

import UIKit

class SuperViewController: UIViewController {
    
    // MARK: - Keyboard Handling Targets
    var keyboardResponsiveView: UIView?
    var keyboardResponsiveScrollView: UIScrollView?
    
    var shouldHandleKeyboardInternally: Bool { true }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shouldHandleKeyboardInternally {
            registerForKeyboardNotifications()
            setupDismissKeyboardGesture()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Alert Utility
    func showAlert(title: String, message: String, actionTitle: String = AppStrings.AlertButton.ok) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        present(alert, animated: true)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func handleKeyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        let height = keyboardFrame.height
        let options = UIView.AnimationOptions(rawValue: animationCurve << 16)
        
        if let scrollView = keyboardResponsiveScrollView {
            scrollView.contentInset.bottom = height
            scrollView.verticalScrollIndicatorInsets.bottom = height
        } else if let container = keyboardResponsiveView {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [options, .beginFromCurrentState]) {
                container.transform = CGAffineTransform(translationX: 0, y: -height + self.view.safeAreaInsets.bottom)
            }
        }
    }
    
    @objc private func handleKeyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let animationCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        let options = UIView.AnimationOptions(rawValue: animationCurve << 16)
        
        if let scrollView = keyboardResponsiveScrollView {
            scrollView.contentInset.bottom = 0
            scrollView.verticalScrollIndicatorInsets.bottom = 0
        } else if let container = keyboardResponsiveView {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [options, .beginFromCurrentState]) {
                container.transform = .identity
            }
        }
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTheKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissTheKeyboard() {
        view.endEditing(true)
    }
    
}

