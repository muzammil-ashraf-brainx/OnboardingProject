//
//  AppError.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 11/06/2025.
//

import Foundation

enum AppError: LocalizedError {
    case emptyField(fieldName: String)
    case invalidEmail
    case passwordTooShort(minLength: Int)
    case passwordsDoNotMatch
    case emailAlreadyExists
    case usernameAlreadyExists
    case invalidCredentials
    case backend(message: String)
    
    var errorDescription: String? {
        switch self {
        case .emptyField(let fieldName):
            return "\(fieldName) is required."
        case .invalidEmail:
            return "Please enter a valid email address."
        case .passwordTooShort(let minLength):
            return "Password must be at least \(minLength) characters long."
        case .passwordsDoNotMatch:
            return "Passwords do not match. Please try again."
        case .emailAlreadyExists:
            return "An account with this email already exists. Please use a different email."
        case .usernameAlreadyExists:
            return "This username is already taken. Please choose another one."
        case .invalidCredentials:
            return "Invalid email or password. Please try again."
        case .backend(let message):
            return message
        }
    }
}

