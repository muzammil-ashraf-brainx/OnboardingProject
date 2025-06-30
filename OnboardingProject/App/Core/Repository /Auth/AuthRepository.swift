//
//  AuthRepository.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 05/06/2025.
//

import Foundation

protocol AuthRepository {
    
    func signup(
        username: String,
        email: String,
        password: String,
        confirmPassword: String,
        completion: @escaping (Result<SignupResponse, Error>) -> Void
    )
    
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<SignupResponse, Error>) -> Void
    )
    
    func resetPassword(
        email: String,
        completion: @escaping (Result<SignupResponse, Error>) -> Void
    )
    
    func verifyOtp(
        code: String,
        completion: @escaping (Result<VerifyOtpResponse, Error>) -> Void
    )
    
}

