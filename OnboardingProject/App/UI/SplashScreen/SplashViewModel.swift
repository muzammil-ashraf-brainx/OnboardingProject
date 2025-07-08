//
//  SplashViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

class SplashViewModel {
    
    // MARK: - Enums
    enum NavigationDestination {
        case signup
        case login
    }
    
    // MARK: - Properties
    var onNavigate: ((NavigationDestination) -> Void)?
    
    // MARK: - Actions
    func handleSignupAction() {
        onNavigate?(.signup)
    }
    
    func handleLoginAction() {
        onNavigate?(.login)
    }
    
}
