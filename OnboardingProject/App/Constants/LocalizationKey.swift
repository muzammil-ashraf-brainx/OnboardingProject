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
        static let press = "getInfo.press"
        static let government = "getInfo.government"
        static let publicFigure = "getInfo.publicFigure"
        static let nonProfit = "getInfo.nonProfit"
        static let business = "getInfo.business"
        static let student = "getInfo.student"
        static let others = "getInfo.others"
        
        static let woman = "getInfo.woman"
        static let man = "getInfo.man"
        static let transgender = "getInfo.transgender"
        static let nonBinary = "getInfo.nonBinary"
        static let preferNotToSay = "getInfo.preferNotToSay"
    }
    
    enum OTP {
        
        static let stepIndicator = "otp.stepIndicator"
        static let instruction = "otp.instruction"
        static let didNotReceive = "otp.didNotReceive"
        static let verify = "otp.verify"
        static let resend = "otp.resend"
        static let sentMessage = "otp.sentMessage"
    }
    
    enum Field {
        
        static let email = "field.email"
        static let username = "field.username"
        static let password = "field.password"
        static let confirmPassword = "field.confirmPassword"
        static let googleSignup = "field.googleSignup"
        static let appleSignup = "field.appleSignup"
        static let forgotPassword = "field.forgotPassword"
    }
    
    enum Validation {
        
        static let signupSuccess = "validation.signupSuccess"
        static let loginSuccess = "validation.loginSuccess"
        static let genericError = "validation.genericError"
        static let emailExists = "validation.emailExists"
        static let usernameExists = "validation.usernameExists"
        static let invalidCredentials = "validation.invalidCredentials"
    }
    
    enum AlertTitle {
        
        static let loginFailed = "alertTitle.loginFailed"
        static let signupFailed = "alertTitle.signupFailed"
        static let error = "alertTitle.error"
        static let success = "alertTitle.success"
        static let incompleteForm = "alertTitle.incompleteForm"
        static let forgotPassword = "alertTitle.forgotPassword"
        static let googleSignup = "alertTitle.googleSignup"
        static let appleSignup = "alertTitle.appleSignup"
        static let validationFailed = "alertTitle.validationFailed"
        static let failedToLoad = "alertTitle.failedToLoad"
        static let verificationFailed = "alertTitle.verificationFailed"
    }
    
    enum AlertMessage {
        
        static let forgotPassword = "alertMessage.forgotPassword"
        static let incompleteForm = "alertMessage.incompleteForm"
        static let googleSignup = "alertMessage.googleSignup"
        static let appleSignup = "alertMessage.appleSignup"
        static let passwordTooShort = "alertMessage.passwordTooShort"
        static let emailEmpty = "alertMessage.emailEmpty"
        static let usernameEmpty = "alertMessage.usernameEmpty"
        static let passwordEmpty = "alertMessage.passwordEmpty"
        static let passwordDoNotMatch = "alertMessage.passwordDoNotMatch"
        static let invalidEmail = "alertMessage.invalidEmail"
        static let unknownServerError = "alertMessage.unknownServerError"
        static let otpVerified = "alertMessage.otpVerified"
        static let enterValidOtp = "alertMessage.enterValidOtp"
    }
    
    enum AlertButton {
        
        static let ok = "alertButton.ok"
        static let cancel = "alertButton.cancel"
        static let tryAgain = "alertButton.tryAgain"
    }
    
    enum RequestError {
        
        static let invalidURL = "requestError.invalidURL"
        static let failedToEncode = "requestError.failedToEncode"
        static let invalidResponse = "requestError.invalidResponse"
        static let noData = "requestError.noData"
        static let unknown = "requestError.unknown"
    }
    
}
