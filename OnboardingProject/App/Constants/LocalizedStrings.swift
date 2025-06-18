//
//  LocalizedStrings.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 22/05/2025.
//

import Foundation

struct LocalizedStrings {
    
    // MARK: - Splash Screen
    static var splashButtonTitle: String {
        String(localized: "splash.buttonsTitle")
    }
    
    static var signupButtonText: String {
        String(localized: "splash.signup")
    }
    
    static var loginButtonText: String {
        String(localized: "splash.login")
    }
    
    // MARK: - GetInfoScreen
        static var getInfoHeader: String {
            String(localized: "getInfo.header")
        }

        static var getInfoDOB: String {
            String(localized: "getInfo.dob")
        }

        static var getInfoNext: String {
            String(localized: "getInfo.next")
        }
    
    // MARK: - OTP Verification
    static var otpStepIndicator: String {
        String(localized: "otp.stepIndicator")
    }

    static var otpInstruction: String {
        String(localized: "otp.instruction")
    }

    static var otpDidNotReceive: String {
        String(localized: "otp.didNotReceive")
    }

    static var otpResend: String {
        String(localized: "otp.resend")
    }

    static var otpVerify: String {
        String(localized: "otp.verify")
    }

}
