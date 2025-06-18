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
            completion(.failure(.emptyField(fieldName: "Email")))
            return
        }
        
        if !trimmedEmail.isValidEmail {
            completion(.failure(.invalidEmail))
            return
        }
        
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
        
        print("Signup Params Being Sent From ViewModel: \(signupRequestParams)")
        
        // MARK: - Call Auth Repo
        
        authRepo.signup(signupRequestParams: signupRequestParams) { result in
            switch result {
            case .success(let response):
                let usernameFromResponse = response.data?.user?.username ?? trimmedUsername
                completion(.success("Signup successful. Welcome, \(usernameFromResponse)."))
            case .failure(let error):
                let message = error.localizedDescription.lowercased()
                
                if message.contains("email already exists") {
                    completion(.failure(.emailAlreadyExists))
                } else if message.contains("username already exists") {
                    completion(.failure(.usernameAlreadyExists))
                } else {
                    completion(.failure(.backend(message: "Something went wrong. Please try again.")))
                }
                
            }
        }
    }
    
}
