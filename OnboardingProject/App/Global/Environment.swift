//
//  Environment.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 19/06/2025.
//

import Foundation

enum Environment {
    
    case development
    
    static var current: Environment {
        return .development
    }
    
    var baseURL: URL {
        switch self {
        case .development:
            return URL(string: "https://enpak-dev.brainxdemo.com/api/v1/")!
        }
    }
    
}
