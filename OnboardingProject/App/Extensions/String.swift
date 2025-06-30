//
//  String.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 17/06/2025.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = AppConstants.Regex.email
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
    
}
