//
//  ChangePasswordViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 24/06/2025.
//

import Foundation

class ChangePasswordViewModel {

    // MARK: - Dependencies
    private let authRepo: AuthRepository
    private let resetURL: String

    // MARK: - Callbacks
    var onSuccess: ((String) -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - Init
    init(authRepo: AuthRepository = DefaultAuthRepository(), resetURL: String) {
        self.authRepo = authRepo
        self.resetURL = resetURL
    }

    func validateFields(password: String?, confirmPassword: String?) -> String? {
        guard let password = password?.trimmingCharacters(in: .whitespacesAndNewlines), !password.isEmpty else {
            return AppStrings.AlertMessage.passwordEmpty
        }
        print(password)

        if password.count < 8 {
            return AppStrings.AlertMessage.passwordTooShort
        }

        guard let confirmPassword = confirmPassword?.trimmingCharacters(in: .whitespacesAndNewlines), !confirmPassword.isEmpty else {
            return AppStrings.AlertMessage.passwordDoNotMatch
        }
        print(confirmPassword)


        if password != confirmPassword {
            return AppStrings.AlertMessage.passwordDoNotMatch
        }

        return nil
    }

    // MARK: - Change Password API
    func changePassword(password: String, confirmPassword: String) {
        authRepo.changePassword(resetURL: resetURL, password: password, confirmPassword: confirmPassword) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let message = response.message
                    self?.onSuccess?(message)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
