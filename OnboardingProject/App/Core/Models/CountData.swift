//
//  CountData.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

import Foundation

struct CountData: Codable {
    let _id: String? //Why underscore
    let followersCount: Int
    let followingCount: Int
    let unreadCount: Int
    
}
