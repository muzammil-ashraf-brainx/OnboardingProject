//
//  ResetpasswordViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import Foundation

class ResetPasswordViewModel {
    
    // MARK: - Properties
    private let authRepo: AuthRepository
    
    // MARK: - Init
    init(authRepo: AuthRepository = DefaultAuthRepository()) {
        self.authRepo = authRepo
    }
    
    // MARK: - Reset Logic
    func resetPassword(
        email: String?,
        completion: @escaping (Result<String, AppError>) -> Void
    ) {
        let trimmedEmail = email?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // Validation
        if trimmedEmail.isEmpty {
            completion(.failure(.emptyField(fieldName: "Email")))
            return
        }
        
        if !trimmedEmail.isValidEmail {
            completion(.failure(.invalidEmail))
            return
        }
        
        let requestParams: [String: Any] = ["email": trimmedEmail]
        
        print("Reset Password Params Sent From ViewModel: \(requestParams)")
        
        authRepo.resetPassword(resetParams: requestParams) { result in
            switch result {
            case .success:
                completion(.success("Reset link sent to \(trimmedEmail)."))
            case .failure(let error):
                completion(.failure(.backend(message: error.localizedDescription)))
            }
        }
    }
    
}
