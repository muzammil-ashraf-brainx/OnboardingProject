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
        confirmPassword: String
    ) async throws -> SignupResponse

    func login(
        username: String,
        password: String
    ) async throws -> SignupResponse

    func resetPassword(
        email: String
    ) async throws -> SignupResponse

    func verifyOtp(
        code: String
    ) async throws -> VerifyOtpResponse
}
