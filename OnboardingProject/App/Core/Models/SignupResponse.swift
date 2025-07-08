//
//  SignupResponse.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 05/06/2025.
//

import Foundation

struct SignupResponse: Codable {
    
    let data: SignupData?
}

struct SignupData: Codable {
    
    let token: String
    let countData: UserStats
    let user: User?
}
