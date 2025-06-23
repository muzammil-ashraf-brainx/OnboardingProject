//
//  OtpVerificationViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

import Foundation

class OTPViewModel {
    
    
    var otpCode: String = "" {
        didSet {
            otpModel = OTPModel(code: otpCode)
            updateUI?()
        }
    }
    
    private var otpModel: OTPModel?
    private let authRepo: AuthRepository = DefaultAuthRepository()
    private var userEmail: String
    
    var updateUI: (() -> Void)?
    var onError: ((String) -> Void)?
    var onSuccess: ((String) -> Void)? 
    var onResendSuccess: (() -> Void)?
    
    var isValidOTP: Bool {
        return otpModel?.isValid ?? false
    }
    
    // MARK: - Init
    init(email: String) {
        self.userEmail = email
    }
    
    // MARK: - Verify OTP
    func verifyOTP(completion: @escaping (Result<VerifyOtpResponse, Error>) -> Void) {
        guard isValidOTP else {
            completion(.failure(NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: AppStrings.AlertMessage.enterValidOtp]
            )))
            return
        }
        
        authRepo.verifyOtp(code: otpCode) { [weak self] result in
            switch result {
            case .success(let response):
                self?.onSuccess?(response.data.resetURL)
                completion(.success(response))
            case .failure(let error):
                self?.onError?(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func resendOTP() {
        authRepo.resetPassword(email: userEmail) { [weak self] result in
            switch result {
            case .success:
                self?.onResendSuccess?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
}
