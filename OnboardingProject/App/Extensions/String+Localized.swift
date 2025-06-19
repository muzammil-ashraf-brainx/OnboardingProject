//
//  String+Localized.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 18/06/2025.
//

import Foundation

extension String {
    var localized: String {
        String(localized: String.LocalizationValue(self))
    }
}
