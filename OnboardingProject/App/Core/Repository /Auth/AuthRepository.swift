//
//  AuthRepository.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 05/06/2025.
//

import Foundation

protocol AuthRepository {
    func signup(signupRequestParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void)
    func login(loginRequestParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void)
    func resetPassword(resetParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void)
    func verifyOtp(otpParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void)
    
}
