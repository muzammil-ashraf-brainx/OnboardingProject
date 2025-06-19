//
//  AppErrorMessages.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 18/06/2025.
//

import Foundation

enum AppErrorMessages {
    static func emptyField(_ fieldName: String) -> String {
        return "\(fieldName) is required."
    }
    
    static let invalidEmail = "Please enter a valid email address."
    static func passwordTooShort(minLength: Int) -> String {
        return "Password must be at least \(minLength) characters long."
    }
    
    static let passwordsDoNotMatch = "Passwords do not match. Please try again."
    static let emailAlreadyExists = "An account with this email already exists. Please use a different email."
    static let usernameAlreadyExists = "This username is already taken. Please choose another one."
    static let invalidCredentials = "Invalid email or password. Please try again."
    
}
