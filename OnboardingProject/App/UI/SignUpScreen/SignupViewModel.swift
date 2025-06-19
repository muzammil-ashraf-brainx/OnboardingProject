//
//  SignupViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 05/06/2025.
//

import Foundation

// MARK: - SignupViewModel

class SignupViewModel {
    
    // MARK: - Properties
    private let authRepo: AuthRepository
    
    // MARK: - Init
    init(authRepo: AuthRepository = DefaultAuthRepository()) {
        self.authRepo = authRepo
    }
    
    // MARK: - Signup Logic
    func signup(
        email: String?,
        username: String?,
        password: String?,
        confirmPassword: String?,
        completion: @escaping (Result<String, AppError>) -> Void
    ) {
        let trimmedEmail = email?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let trimmedUsername = username?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let trimmedPassword = password ?? ""
        let trimmedConfirmPassword = confirmPassword ?? ""
        
        // MARK: - Validation
        if trimmedEmail.isEmpty {
            completion(.failure(.emptyField(fieldName: AppStrings.FieldName.email)))
            return
        }
        
        if !isValidEmail(trimmedEmail) {
            completion(.failure(.invalidEmail))
            return
        }
        
        if trimmedUsername.isEmpty {
            completion(.failure(.emptyField(fieldName: AppStrings.FieldName.username)))
            return
        }
        
        if trimmedPassword.isEmpty {
            completion(.failure(.emptyField(fieldName: AppStrings.FieldName.password)))
            return
        }
        
        if trimmedPassword.count < 8 {
            completion(.failure(.passwordTooShort(minLength: 8)))
            return
        }
        
        if trimmedConfirmPassword != trimmedPassword {
            completion(.failure(.passwordsDoNotMatch))
            return
        }
        
        let signupRequestParams: [String: Any] = [
            "username": trimmedUsername,
            "email": trimmedEmail,
            "password": trimmedPassword,
            "confirmPassword": trimmedConfirmPassword
        ]
        
        // MARK: - Call Auth Repo
        authRepo.signup(signupRequestParams: signupRequestParams) { result in
            switch result {
            case .success(let response):
                let usernameFromResponse = response.data?.user?.username ?? trimmedUsername
                completion(.success("\(AppStrings.Validation.signupSuccess), \(usernameFromResponse)."))
                
            case .failure(let error):
                let message = error.localizedDescription.lowercased()
                
                if message.contains(AppStrings.Validation.emailExists) {
                    completion(.failure(.emailAlreadyExists))
                } else if message.contains(AppStrings.Validation.usernameExists) {
                    completion(.failure(.usernameAlreadyExists))
                } else {
                    completion(.failure(.backend(message: AppStrings.Validation.genericError)))
                }
            }
        }
    }
    
    // MARK: - Email Format Validator
    private func isValidEmail(_ email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", AppRegex.email).evaluate(with: email)
    }
    
}
