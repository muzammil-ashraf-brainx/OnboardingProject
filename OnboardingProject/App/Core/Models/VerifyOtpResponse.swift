//
//  VerifyOtpResponse.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 23/06/2025.
//

import Foundation
struct VerifyOtpResponse: Decodable {
    let data: ResetData
    let message: String
}

struct ResetData: Decodable {
    let resetURL: String
}

