//
//  GetInfoViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/05/2025.
//

import Foundation

class GetInfoViewModel {
    var sections: [[String]] = GetInfoSectionData.sections
    var selectedIndices: [Int?] = GetInfoSectionData.initialSelectedIndices
    var selectedDOB: Date?
    
    var isValid: Bool {
        return selectedIndices.allSatisfy { $0 != nil } && selectedDOB != nil
    }
    
}

