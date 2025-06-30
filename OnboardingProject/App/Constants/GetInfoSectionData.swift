//
//  GetInfoSectionData.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import Foundation

struct GetInfoSectionData {
    
    static let identityOptions = IdentityType.allCases
    static let genderOptions = GenderType.allCases
    
    static let sections: [[String]] = [
        identityOptions.map { $0.localized },
        genderOptions.map { $0.localized }
    ]
    
    static let initialSelectedIndices: [Int?] = Array(repeating: nil, count: sections.count)
    
}

