//
//  ResetPasswordViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 23/06/2025.
//

import Combine
import Foundation

@MainActor
class ResetPasswordViewModel {
    private let authRepo: AuthRepository
    
    // MARK: - Publishers
    let resetSuccess = PassthroughSubject<String, Never>()
    let resetFailure = PassthroughSubject<String, Never>()
    
    // MARK: - Init
    init(authRepo: AuthRepository = DefaultAuthRepository()) {
        self.authRepo = authRepo
    }
    
    // MARK: -  Validate Fields
    public func validateEmailField(email: String?) -> String? {
        let trimmedEmail = email?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if trimmedEmail.isEmpty {
            return LocalizationKey.AlertMessage.emailEmpty.localized
        }
        
        if !isValidEmail(trimmedEmail) {
            return LocalizationKey.AlertMessage.invalidEmail.localized
        }
        
        return nil
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", AppConstants.Regex.email).evaluate(with: email)
    }
    
    func resetPassword(email: String) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Task {
            do {
                _ = try await authRepo.resetPassword(email: trimmedEmail)
                resetSuccess.send(trimmedEmail)
            }
            catch {
                resetFailure.send(error.localizedDescription)
            }
        }
    }
}

