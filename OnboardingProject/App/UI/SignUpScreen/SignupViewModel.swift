//
//  SignupViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 05/06/2025.
//

import Foundation

class SignupViewModel {
    
    // MARK: - Properties
    private let authRepo: AuthRepository
    
    var onSignupSuccess: ((String) -> Void)?
    var onSignupFailure: ((String) -> Void)?
    var onValidationFailure: ((ValidationError) -> Void)?
    
    // MARK: - Initialization
    init(authRepo: AuthRepository = DefaultAuthRepository()) {
        self.authRepo = authRepo
    }

    // MARK: - Signup Entry Point
    func signup(email: String?, username: String?, password: String?, confirmPassword: String?) {
        guard let email = email?.trimmingCharacters(in: .whitespacesAndNewlines),
              let username = username?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = password,
              let confirmPassword = confirmPassword else {
            return
        }

        if let error = validate(email: email, username: username, password: password, confirmPassword: confirmPassword) {
            onValidationFailure?(error)
            return
        }

        signupWithAPI(email: email, username: username, password: password)
    }

    // MARK: - Validation
    private func validate(email: String, username: String, password: String, confirmPassword: String) -> ValidationError? {
        if email.isEmpty {
            return .emailEmpty
        }

        if !isValidEmail(email) {
            return .invalidEmail
        }

        if username.isEmpty {
            return .usernameEmpty
        }

        if password.isEmpty {
            return .passwordEmpty
        }

        if password.count < 8 {
            return .passwordTooShort
        }

        if confirmPassword != password {
            return .passwordsDoNotMatch
        }

        return nil
    }

    private func isValidEmail(_ email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", AppConstants.Regex.email).evaluate(with: email)
    }

    // MARK: - Signup Logic
    private func signupWithAPI(email: String, username: String, password: String) {
        authRepo.signup(
            username: username,
            email: email,
            password: password,
            confirmPassword: password
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let name = response.data?.user?.username ?? username
                    let message = "\(LocalizationKey.Validation.signupSuccess), \(name)."
                    self?.onSignupSuccess?(message)
                case .failure(let error):
                    self?.onSignupFailure?(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - Validation Errors
extension SignupViewModel {
    enum ValidationError: LocalizedError {
        case emailEmpty
        case invalidEmail
        case usernameEmpty
        case passwordEmpty
        case passwordTooShort
        case passwordsDoNotMatch

        var errorDescription: String? {
            switch self {
            case .emailEmpty:
                return LocalizationKey.AlertMessage.emailEmpty.localized
            case .invalidEmail:
                return LocalizationKey.AlertMessage.invalidEmail.localized
            case .usernameEmpty:
                return LocalizationKey.AlertMessage.usernameEmpty.localized
            case .passwordEmpty:
                return LocalizationKey.AlertMessage.passwordEmpty.localized
            case .passwordTooShort:
                return LocalizationKey.AlertMessage.passwordTooShort.localized
            case .passwordsDoNotMatch:
                return LocalizationKey.AlertMessage.passwordDoNotMatch.localized
            }
        }
    }
}

