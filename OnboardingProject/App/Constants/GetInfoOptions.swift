//
//  GetInfoOptions.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 18/06/2025.
//

import Foundation

enum IdentityType: String, CaseIterable {
    case press = "Press"
    case government = "Government"
    case publicFigure = "Public Figure"
    case nonProfit = "Non-profit"
    case business = "Business"
    case student = "Student"
    case others = "Others"
    
}

enum GenderType: String, CaseIterable {
    case woman = "Woman"
    case man = "Man"
    case transgender = "Transgender"
    case nonBinary = "Non-binary"
    case preferNotToSay = "Not to say"
    
}
