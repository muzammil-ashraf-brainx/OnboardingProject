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
        let trimmedUsername = username?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let trimmedPassword = password?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if let error = validate(username: trimmedUsername, password: trimmedPassword) {
            onValidationFailed?(error.localizedDescription)
            return
        }
        
        authRepo.login(
            username: trimmedUsername,
            password: trimmedPassword
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onLoginSuccess?()
                case .failure(let error):
                    self?.onLoginFailure?(error.localizedDescription)
                }
            }
        }
    }
    
    func triggerForgotPassword() {
        onForgotPassword?()
    }
    
    // MARK: - Validation
    private func validate(username: String, password: String) -> ValidationError? {
        if username.isEmpty {
            return .usernameEmpty
        }
        
        if password.isEmpty {
            return .passwordEmpty
        }
        
        if password.count < 8 {
            return .passwordTooShort
        }
        
        return nil
    }
}

// MARK: - Validation Errors
extension LoginViewModel {
    enum ValidationError: LocalizedError {
        case usernameEmpty
        case passwordEmpty
        case passwordTooShort
        
        var errorDescription: String? {
            switch self {
            case .usernameEmpty:
                return LocalizationKey.AlertMessage.usernameEmpty.localized
            case .passwordEmpty:
                return LocalizationKey.AlertMessage.passwordEmpty.localized
            case .passwordTooShort:
                return LocalizationKey.AlertMessage.passwordTooShort.localized
            }
        }
    }
    
}
