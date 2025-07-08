//
//  VerifyOtpResponse.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 23/06/2025.
//

import Foundation

struct VerifyOtpResponse: Codable {
    
    let data: ResetData
    let message: String
}

struct ResetData: Codable {
    
    let resetURL: String
}

