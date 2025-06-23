//
//  LocalizationKey.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 18/06/2025.
//

import Foundation

enum LocalizationKey {
    enum Splash {
        static let buttonTitle = "splash.buttonsTitle"
        static let signup = "splash.signup"
        static let login = "splash.login"
    }
    
    enum GetInfo {
        static let header = "getInfo.header"
        static let dob = "getInfo.dob"
        static let next = "getInfo.next"
    }
    
    enum OTP {
           static let stepIndicator = "otp.stepIndicator"
           static let instruction = "otp.instruction"
           static let didNotReceive = "otp.didNotReceive"
           static let verify = "otp.verify"
           static let resend = "otp.resend"
           static let sentMessage = "otp.sentMessage"
       }
    
}
