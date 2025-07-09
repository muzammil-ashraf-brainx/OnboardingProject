//
//  OtpVerificationViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

import Combine
import Foundation

@MainActor
class OTPViewModel {
    
    // MARK: - Input
    @Published var otpCode: String = .empty
    
    // MARK: - Output Publishers
    let updateUI = PassthroughSubject<Void, Never>()
    let success = PassthroughSubject<String, Never>()
    let error = PassthroughSubject<String, Never>()
    let resendSuccess = PassthroughSubject<Void, Never>()
    
    // MARK: - Private
    private var otpModel: OTPModel?
    private let authRepo: AuthRepository = DefaultAuthRepository()
    private var userEmail: String
    private var cancellables = Set<AnyCancellable>()
    
    var isValidOTP: Bool {
        return otpModel?.isValid ?? false
    }
    
    // MARK: - Init
    init(email: String) {
        self.userEmail = email
        bindOtpCode()
    }
    
    private func bindOtpCode() {
        $otpCode
            .sink { [weak self] code in
                self?.otpModel = OTPModel(code: code)
                self?.updateUI.send()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Verify OTP
    func verifyOTP() {
        guard isValidOTP else {
            error.send(LocalizationKey.AlertMessage.enterValidOtp.localized)
            return
        }
        
        Task {
            do {
                let response = try await authRepo.verifyOtp(code: otpCode)
                
                self.success.send(response.data.resetURL)
                
            } catch {
                self.error.send(error.localizedDescription)
                
            }
        }
    }
    
    // MARK: - Resend OTP
    func resendOTP() {
        Task {
            do {
                _ = try await authRepo.resetPassword(email: userEmail)
                self.resendSuccess.send()
                
            } catch {
                
                self.error.send(error.localizedDescription)
                
            }
        }
    }
}
