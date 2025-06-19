//
//  LoginViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import Foundation


class LoginViewModel {
    
    // MARK: - Properties
    private let authRepo: AuthRepository
    
    // MARK: - Init
    init(authRepo: AuthRepository = DefaultAuthRepository()) {
        self.authRepo = authRepo
    }
    
    // MARK: - Login Logic
    func login(
        username: String?,
        password: String?,
        completion: @escaping (Result<String, AppError>) -> Void
    ) {
        let trimmedUsername = username?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let trimmedPassword = password ?? ""
        
        // MARK: - Validation
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
        
        let loginRequestParams: [String: Any] = [
            "username": trimmedUsername,
            "password": trimmedPassword
        ]
        
        // MARK: - Call Auth Repo
        authRepo.login(loginRequestParams: loginRequestParams) { result in
            switch result {
            case .success(let response):
                let usernameFromResponse = response.data?.user?.username ?? trimmedUsername
                completion(.success("\(AppStrings.Validation.loginSuccess), \(usernameFromResponse)."))
                
            case .failure(let error):
                let message = error.localizedDescription.lowercased()
                
                if message.contains(AppStrings.Validation.invalidCredentials.lowercased()) {
                    completion(.failure(.invalidCredentials))
                } else {
                    completion(.failure(.backend(message: AppStrings.Validation.genericError)))
                }
            }
        }
    }
    
}
