//
//  LoginViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import Foundation

// MARK: - LoginViewModel

final class LoginViewModel {
    
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
            completion(.failure(.emptyField(fieldName: "Username")))
            return
        }
        
        if trimmedPassword.isEmpty {
            completion(.failure(.emptyField(fieldName: "Password")))
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
        
        print("Login Params Being Sent From ViewModel: \(loginRequestParams)")
        
        // MARK: - Call Auth Repo
        authRepo.login(loginRequestParams: loginRequestParams) { result in
            switch result {
            case .success(let response):
                let usernameFromResponse = response.data?.user?.username ?? trimmedUsername
                completion(.success("Login successful. Welcome back, \(usernameFromResponse)."))
                
            case .failure(let error):
                let message = error.localizedDescription.lowercased()
                
                if message.contains("invalid username or password") {
                    completion(.failure(.invalidCredentials))
                } else {
                    completion(.failure(.backend(message: "Something went wrong. Please try again.")))
                }
            }
        }
    }
}

