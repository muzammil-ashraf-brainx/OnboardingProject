//
//  LoginViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Callbacks
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    var onValidationFailed: ((String) -> Void)?
    var onForgotPassword: (() -> Void)?
    
    private let authRepo: AuthRepository
    
    // MARK: - Init
    init(authRepo: AuthRepository = DefaultAuthRepository()) {
        self.authRepo = authRepo
    }
    
    // MARK: - Public Methods
    func login(username: String?, password: String?) {
        guard let username = username,
              let password = password,
              !username.isEmpty,
              !password.isEmpty else {
            onValidationFailed?(AppStrings.AlertMessage.incompleteForm)
            return
        }
        
        if let validationError = validateCredentials(username: username, password: password) {
            onValidationFailed?(validationError)
            return
        }
        
        authRepo.login(
            username: username.trimmingCharacters(in: .whitespacesAndNewlines),
            password: password
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onLoginSuccess?()
                case .failure(let error):
                    print(error)
                    self?.onLoginFailure?(error.localizedDescription)
                }
            }
        }
    }
    
    func triggerForgotPassword() {
        onForgotPassword?()
    }
    
    // MARK: - Validation
    private func validateCredentials(username: String?, password: String?) -> String? {
        let trimmedUsername = username?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let trimmedPassword = password ?? ""
        
        if trimmedUsername.isEmpty {
            return AppStrings.AlertMessage.usernameEmpty
        }
        
        if trimmedPassword.isEmpty {
            return AppStrings.AlertMessage.passwordEmpty
        }
        
        if trimmedPassword.count < 8 {
            return AppStrings.AlertMessage.passwordTooShort
        }
        
        return nil
    }
    
}

