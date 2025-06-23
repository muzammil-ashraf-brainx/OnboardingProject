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
            return "The URL is invalid."
        case .failedToEncodeParameters:
            return "Failed to encode request parameters."
        case .invalidResponse:
            return "The server response was invalid."
        case .noData:
            return "No data was returned from the server."
        case .unknownServerError:
            return "An unexpected server error occurred."
        }
    }
}

struct APIError: LocalizedError {
    let message: String

    var errorDescription: String? {
        message
    }

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

