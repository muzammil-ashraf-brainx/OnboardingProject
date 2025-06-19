//
//  LocalizedStrings.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 22/05/2025.
//  Updated: 18/06/2025 by BrainX iOS Dev
//

import Foundation

struct LocalizedStrings {
    
    // MARK: - Splash Screen
    static var splashButtonTitle: String {
        LocalizationKey.Splash.buttonTitle.localized
    }
    
    static var signupButtonText: String {
        LocalizationKey.Splash.signup.localized
    }

    static var loginButtonText: String {
        LocalizationKey.Splash.login.localized
    }

    // MARK: - GetInfo Screen
    static var getInfoHeader: String {
        LocalizationKey.GetInfo.header.localized
    }

    static var getInfoDOB: String {
        LocalizationKey.GetInfo.dob.localized
    }

    static var getInfoNext: String {
        LocalizationKey.GetInfo.next.localized
    }
    
}

