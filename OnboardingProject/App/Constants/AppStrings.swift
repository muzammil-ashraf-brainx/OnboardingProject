//
//  AppStrings.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/06/2025.
//

import Foundation

enum AppStrings {
    
    enum FieldName {
        static let email = "Email"
        static let username = "Username"
        static let password = "Password"
        static let confirmPassword = "Confirm Password"
        static let googleSignup = "Google Signup"
        static let appleSignup = "Apple Signup"
        static let forgotPassword = "Forgot Password"
    }
    
    enum Validation {
        static let signupSuccess = "Signup successful. Welcome"
        static let loginSuccess = "Login Successful. Welcome Back"
        static let genericError = "Something went wrong. Please try again."
        static let emailExists = "email already exists"
        static let usernameExists = "username already exists"
        static let invalidCredentials = "Invalid username or password"
    }
    
    enum AlertTitle {
        static let loginFailed = "Login Failed"
        static let forgotPassword = "Forgot Password"
        static let signupFailed = "Signup Failed"
        static let incompleteForm = "Incomplete Form"
        static let error = "Error"
        static let success = "Success"
        static let googleSignup = "Google Signup"
        static let appleSignup = "Apple Signup"
        
    }
    
    enum AlertMessage {
        static let forgotPassword = "This feature is not implemented yet."
        static let incompleteForm = "Please complete all required fields before proceeding."
        static let googleSignup = "Google signup not implemented yet."
        static let appleSignup = "Apple signup not implemented yet."
        
    }
    
    enum AlertButton {
        static let ok = "OK"
        static let cancel = "Cancel"
        static let tryAgain = "Try Again"
    }
    
}
