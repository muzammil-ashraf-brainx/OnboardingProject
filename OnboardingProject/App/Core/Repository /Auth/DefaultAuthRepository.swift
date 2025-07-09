//
//  DefaultAuthRepository.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import Alamofire
import Foundation

class DefaultAuthRepository: AuthRepository {
    private let session: Session
    
    init(session: Session = NetworkSession.shared) {
        self.session = session
    }
    
    func signup(
        username: String,
        email: String,
        password: String,
        confirmPassword: String
    ) async throws -> SignupResponse {
        try await executeRequest(
            .signup(
                username: username,
                email: email,
                password: password,
                confirmPassword: confirmPassword)
        )
    }
    
    func login(
        username: String,
        password: String
    ) async throws -> SignupResponse {
        try await executeRequest(
            .login(
                username: username,
                password: password)
        )
    }
    
    func resetPassword(
        email: String
    ) async throws -> SignupResponse {
        try await executeRequest(.resetPassword(email: email))
    }
    
    func verifyOtp(
        code: String
    ) async throws -> VerifyOtpResponse {
        try await executeRequest(.verifyOtp(code: code))
    }
    
    // MARK: - Generic async/await request
    private func executeRequest<T: Decodable>(_ request: Request) async throws -> T {
        guard let url = request.url else {
            throw RequestError.invalidURL
        }
        
        let dataTask = session.request(
            url,
            method: request.method,
            parameters: request.parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(request.headers)
        )
            .validate()
            .serializingDecodable(T.self)
        
        do {
            return try await dataTask.value
        } catch {
            if let afError = error.asAFError,
               let responseCode = afError.responseCode {
                throw mapError(statusCode: responseCode)
            }
            throw error
        }
    }
    
    private func mapError(statusCode: Int) -> RequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 429: return .rateLimited
        case 500...599: return .serverError
        default: return .unknownServerError
        }
    }
}

// MARK: - API Request Definitions
extension DefaultAuthRepository {
    
    // MARK: - Auth API Requests
    enum Request {
        case signup(username: String, email: String, password: String, confirmPassword: String)
        case login(username: String, password: String)
        case resetPassword(email: String)
        case verifyOtp(code: String)
        
        var url: URL? {
            switch self {
            case .signup:
                return URL(string: APIEndpoints.Auth.signup, relativeTo: Environment.current.baseURL)
            case .login:
                return URL(string: APIEndpoints.Auth.login, relativeTo: Environment.current.baseURL)
            case .resetPassword:
                return URL(string: APIEndpoints.Auth.resetPassword, relativeTo: Environment.current.baseURL)
            case .verifyOtp:
                return URL(string: APIEndpoints.Auth.verifyOtp, relativeTo: Environment.current.baseURL)
            }
        }
        
        var method: Alamofire.HTTPMethod {
            switch self {
            case .signup,
                    .login,
                    .resetPassword,
                    .verifyOtp:
                return .post
            }
        }
        
        var headers: [String: String] {
            [NetworkHeaders.contentType(): NetworkHeaderValues.json()]
        }
        
        var parameters: [String: Any] {
            switch self {
            case let .signup(username, email, password, confirmPassword):
                return [
                    "username": username,
                    "email": email,
                    "password": password,
                    "confirmPassword": confirmPassword
                ]
            case let .login(username, password):
                return [
                    "username": username,
                    "password": password
                ]
            case let .resetPassword(email):
                return [
                    "email": email
                ]
            case let .verifyOtp(code):
                return [
                    "otp": code
                ]
            }
        }
    }
}

