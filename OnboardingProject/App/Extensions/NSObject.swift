//
//  NSObject.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 21/05/2025.
//

import Foundation

extension NSObject {
    
    static var identifier: String? {
        return NSStringFromClass(self).components(separatedBy: ".").last
    }
    
}
