//
//  SignupViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import Foundation

enum SignupError: Error, LocalizedError {
    case emptyEmail
    case invalidEmail
    case emptyUsername
    case emptyPassword
    case passwordsDoNotMatch
    case signupFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .emptyEmail: return "Email cannot be empty."
        case .invalidEmail: return "Invalid email format."
        case .emptyUsername: return "Username cannot be empty."
        case .emptyPassword: return "Password cannot be empty."
        case .passwordsDoNotMatch: return "Passwords do not match."
        case .signupFailed(let message): return message
        }
    }
}

class SignupViewModel {
    
    // MARK: - Properties
    private let authRepo: AuthRepository
    
    // MARK: - Initializer
    init(authRepo: AuthRepository = DefaultAuthRepository()) {
        self.authRepo = authRepo
    }
    
    // MARK: - API Call
    func signup(email: String?, username: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<String, SignupError>) -> Void) {
        // Validate inputs
        guard let email = email, !email.isEmpty else {
            completion(.failure(.emptyEmail))
            return
        }
        guard isValidEmail(email) else {
            completion(.failure(.invalidEmail))
            return
        }
        guard let username = username, !username.isEmpty else {
            completion(.failure(.emptyUsername))
            return
        }
        guard let password = password, !password.isEmpty else {
            completion(.failure(.emptyPassword))
            return
        }
        guard let confirmPassword = confirmPassword, password == confirmPassword else {
            completion(.failure(.passwordsDoNotMatch))
            return
        }
        
        let signupRequestParams: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword
        ]
        
        authRepo.signup(signupRequestParams: signupRequestParams) { result in
            switch result {
            case .success(let response):
                let usernameFromResponse = response.data?.user?.username ?? username
                completion(.success("Signup successful. Welcome, \(usernameFromResponse)!"))
            case .failure(let error):
                completion(.failure(.signupFailed(error.localizedDescription)))
            }
        }
    }
    
    // MARK: - Validation
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}
