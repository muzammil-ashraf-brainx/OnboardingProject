//
//  APIResponse.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 24/06/2025.
//
import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let data: T
    let message: String
}
struct ResetData: Decodable {
    let resetURL: String
}

struct TokenData: Decodable {
    let token: String
}
