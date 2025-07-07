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
    func verifyOTP() {
        guard isValidOTP else {
            onError?(LocalizationKey.AlertMessage.enterValidOtp.localized)
            return
        }
        
        authRepo.verifyOtp(code: otpCode) { [weak self] result in
            switch result {
            case .success(let response):
                self?.onSuccess?(response.data.resetURL)
            case .failure(let error):
                self?.onError?(error.localizedDescription)
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
