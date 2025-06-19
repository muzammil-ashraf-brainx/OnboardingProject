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
            return AppErrorMessages.emptyField(fieldName)
        case .invalidEmail:
            return AppErrorMessages.invalidEmail
        case .passwordTooShort(let minLength):
            return AppErrorMessages.passwordTooShort(minLength: minLength)
        case .passwordsDoNotMatch:
            return AppErrorMessages.passwordsDoNotMatch
        case .emailAlreadyExists:
            return AppErrorMessages.emailAlreadyExists
        case .usernameAlreadyExists:
            return AppErrorMessages.usernameAlreadyExists
        case .invalidCredentials:
            return AppErrorMessages.invalidCredentials
        case .backend(let message):
            return message
        }
    }
    
}

