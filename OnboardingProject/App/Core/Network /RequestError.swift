//
//  RequestError.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 20/06/2025.
//

import Foundation

enum RequestError: LocalizedError {
    
    case invalidURL
    case failedToEncodeParameters
    case invalidResponse
    case noData
    case unknownServerError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return LocalizationKey.RequestError.invalidURL.localized
        case .failedToEncodeParameters:
            return LocalizationKey.RequestError.failedToEncode.localized
        case .invalidResponse:
            return LocalizationKey.RequestError.invalidResponse.localized
        case .noData:
            return LocalizationKey.RequestError.noData.localized
        case .unknownServerError:
            return LocalizationKey.RequestError.unknown.localized
        }
    }
}

struct APIError: LocalizedError {
    let message: String
    
    var errorDescription: String? {
        message
    }
    
    // MARK: - Initializers
    
    init(message: String) {
        self.message = message
    }
    
    init(data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: String],
           let errorMessage = json[BackendKeys.errorMessage] {
            self.message = errorMessage
        } else {
            self.message = RequestError.unknownServerError.localizedDescription
        }
    }
    
}

