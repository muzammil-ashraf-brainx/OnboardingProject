//
//  GetInfoOptions.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 18/06/2025.
//

import Foundation

enum IdentityType: CaseIterable {
    
    case press
    case government
    case publicFigure
    case nonProfit
    case business
    case student
    case others
    
    var localized: String {
        switch self {
        case .press:
            return LocalizationKey.GetInfo.press.localized
        case .government:
            return LocalizationKey.GetInfo.government.localized
        case .publicFigure:
            return LocalizationKey.GetInfo.publicFigure.localized
        case .nonProfit:
            return LocalizationKey.GetInfo.nonProfit.localized
        case .business:
            return LocalizationKey.GetInfo.business.localized
        case .student:
            return LocalizationKey.GetInfo.student.localized
        case .others:
            return LocalizationKey.GetInfo.others.localized
        }
    }
    
}

enum GenderType: CaseIterable {
    
    case woman
    case man
    case transgender
    case nonBinary
    case preferNotToSay
    
    var localized: String {
        switch self {
        case .woman:
            return LocalizationKey.GetInfo.woman.localized
        case .man:
            return LocalizationKey.GetInfo.man.localized
        case .transgender:
            return LocalizationKey.GetInfo.transgender.localized
        case .nonBinary:
            return LocalizationKey.GetInfo.nonBinary.localized
        case .preferNotToSay:
            return LocalizationKey.GetInfo.preferNotToSay.localized
        }
    }
    
}
