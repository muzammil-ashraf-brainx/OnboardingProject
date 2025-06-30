//
//  User.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import Foundation

struct User: Codable {
    
    let name: String
    let username: String
    let email: String
    let verifiedEmail: String
    let idImage: String
    let verificationStatus: String
    let isVarified: Bool
    let gender: String
    let profession: String
    let dob: String?
    let intro: String
    let avatar: String
    let blockedUsers: [String]
    let blockedBy: [String]
    let authProvider: String
    let password: String
    let _id: String
    let firebaseTokens: [String]
    let createdAt: String
    let updatedAt: String
    let __v: Int
}
