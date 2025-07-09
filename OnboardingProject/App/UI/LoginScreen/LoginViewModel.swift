//
//  LoginViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import Combine
import Foundation

@MainActor
class LoginViewModel {
    
    // MARK: - Publishers
    let loginSuccess = PassthroughSubject<Void, Never>()
    let loginFailure = PassthroughSubject<String, Never>()
    let validationFailure = PassthroughSubject<String, Never>()
    let forgotPassword = PassthroughSubject<Void, Never>()
    
    // MARK: - Dependencies
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
            validationFailure.send(error.localizedDescription)
            return
        }
        
        Task {
            do {
                _ = try await authRepo.login(
                    username: trimmedUsername,
                    password: trimmedPassword
                )
                loginSuccess.send()
            } catch {
                loginFailure.send(error.localizedDescription)
            }
        }
    }
    
    func triggerForgotPassword() {
        forgotPassword.send()
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

