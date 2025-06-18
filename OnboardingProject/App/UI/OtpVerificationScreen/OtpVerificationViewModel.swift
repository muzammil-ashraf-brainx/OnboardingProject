//
//  OtpVerificationViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//


import Foundation

class OTPViewModel {

    // MARK: - Properties

    var otpCode: String = "" {
        didSet {
            otpModel = OTPModel(code: otpCode)
            updateUI?()
        }
    }

    private var otpModel: OTPModel?
    private let authRepo: AuthRepository = DefaultAuthRepository()

    var updateUI: (() -> Void)?
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?

    var isValidOTP: Bool {
        return otpModel?.isValid ?? false
    }

    // MARK: - Call Auth Repo

    func verifyOTP(email: String, completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        guard isValidOTP else {
            completion(.failure(NSError(domain: "Please enter a valid 4-digit OTP.", code: -1)))
            return
        }

        let otpRequestParams: [String: Any] = [
            "email": email,
            "code": otpCode
        ]

        authRepo.verifyOtp(otpParams: otpRequestParams) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func resendOTP() {
        // To be implemented
    }
}
