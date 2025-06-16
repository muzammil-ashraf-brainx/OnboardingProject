//
//  GetInfoSectionData.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/06/2025.
//

import Foundation

struct GetInfoSectionData {
    
    static let sections: [[String]] = [
        ["Press", "Government", "Public Figure", "Non-profit", "Business", "Student", "Others"],
        ["Woman", "Man", "Transgender", "Non-binary", "Not to say"]
    ]
    
    static let initialSelectedIndices: [Int?] = Array(repeating: nil, count: sections.count)
    
}
