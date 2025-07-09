//
//  SplashViewModel.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import Combine

class SplashViewModel {
    
    // MARK: - Enums
    enum NavigationDestination {
        case signup
        case login
    }
    
    // MARK: - Publishers
    let navigationPublisher = PassthroughSubject<NavigationDestination, Never>()
    
    // MARK: - Actions
    func handleSignupAction() {
        navigationPublisher.send(.signup)
    }
    
    func handleLoginAction() {
        navigationPublisher.send(.login)
    }
}
