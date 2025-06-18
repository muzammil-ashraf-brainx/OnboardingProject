//
//  OTPModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

import Foundation

struct OTPModel {
    let code: String
    let isValid: Bool
    
    init(code: String) {
        self.code = code
        self.isValid = code.count == 4 && Int(code) != nil && code.allSatisfy { $0.isNumber }
    }
}
