//
//  CountData.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 10/06/2025.
//

struct UserStats: Codable {
    
    let id: String?
    let followers: Int
    let following: Int
    let unread: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case followers = "followersCount"
        case following = "followingCount"
        case unread = "unreadCount"
    }
    
}
