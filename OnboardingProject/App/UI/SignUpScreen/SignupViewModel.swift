//
//  SignupViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 05/06/2025.
//

import Foundation

class SignupViewModel {
    
    private let authRepo: AuthRepository
    
    var onSignupSuccess: ((String) -> Void)?
    var onSignupFailure: ((String) -> Void)?
    
    init(authRepo: AuthRepository = DefaultAuthRepository()) {
        self.authRepo = authRepo
    }
    
    // MARK: - Validation
    public func validateSignupFields(
        email: String?,
        username: String?,
        password: String?,
        confirmPassword: String?
    ) -> String? {
        let trimmedEmail = email?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let trimmedUsername = username?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let trimmedPassword = password ?? ""
        let trimmedConfirmPassword = confirmPassword ?? ""
        
        if trimmedEmail.isEmpty {
            return AppStrings.AlertMessage.emailEmpty
        }
        
        if !isValidEmail(trimmedEmail) {
            return AppStrings.AlertMessage.invalidEmail
        }
        
        if trimmedUsername.isEmpty {
            return AppStrings.AlertMessage.usernameEmpty
        }
        
        if trimmedPassword.isEmpty {
            return AppStrings.AlertMessage.passwordEmpty
        }
        
        if trimmedPassword.count < 8 {
            return AppStrings.AlertMessage.passwordTooShort
        }
        
        if trimmedConfirmPassword != trimmedPassword {
            return AppStrings.AlertMessage.passwordDoNotMatch
        }
        
        return nil
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", AppRegex.email).evaluate(with: email)
    }
    
    // MARK: - Signup Logic
    func signup(
        email: String,
        username: String,
        password: String
    ) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        
        authRepo.signup(
            username: trimmedUsername,
            email: trimmedEmail,
            password: password,
            confirmPassword: password
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let usernameFromResponse = response.data?.user?.username ?? trimmedUsername
                    let successMessage = "\(AppStrings.Validation.signupSuccess), \(usernameFromResponse)."
                    self?.onSignupSuccess?(successMessage)
                case .failure(let error):
                    self?.onSignupFailure?(error.localizedDescription)
                }
            }
        }
    }
    
}

