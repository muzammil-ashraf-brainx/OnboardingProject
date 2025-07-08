//
//  NetworkSession.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 08/07/2025.
//

import Alamofire
import Foundation

enum NetworkSession {
    
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        return Session(configuration: configuration)
    }()
}
