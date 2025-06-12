//
//  SignupViewController.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signupView: SignupView!
    
    // MARK: - Properties
    private var activeField: UIView?
    private let viewModel = SignupViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signupView.setupDelegates(self)
        registerForKeyboardNotifications()
        setupDismissKeyboardGesture()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    @IBAction func signupBtnTapped(_ sender: Any) {
        viewModel.signup(
            email: signupView.email,
            username: signupView.username,
            password: signupView.password,
            confirmPassword: signupView.confirmPassword
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    let getInfoVC = GetInfoViewController(nibName: "GetInfoViewController", bundle: nil)
                    self?.navigationController?.pushViewController(getInfoVC, animated: true)
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
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
    
    // MARK: - Dismiss Keyboard
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - SignupViewDelegate
extension SignupViewController: SignupViewDelegate {
    func didTapLoginNow() {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func didBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func didEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func didTapGoogleSignup() {
        let alert = UIAlertController(title: "Google Signup", message: "Google signup not implemented yet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func didTapAppleSignup() {
        let alert = UIAlertController(title: "Apple Signup", message: "Apple signup not implemented yet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
