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
    
    
    // MARK: - Public API Calls
    func signup(
        username: String,
        email: String,
        password: String,
        confirmPassword: String,
        completion: @escaping (Result<SignupResponse, Error>) -> Void
    ) {
        executeRequest(
            .signup(username: username, email: email, password: password, confirmPassword: confirmPassword),
            completion: completion
        )
    }
    
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<SignupResponse, Error>) -> Void
    ) {
        executeRequest(
            .login(username: username, password: password),
            completion: completion
        )
    }
    
    func resetPassword(
        email: String,
        completion: @escaping (Result<SignupResponse, Error>) -> Void
    ) {
        executeRequest(
            .resetPassword(email: email),
            completion: completion
        )
    }
    
    func verifyOtp(
        code: String,
        completion: @escaping (Result<VerifyOtpResponse, Error>) -> Void
    ) {
        executeRequest(
            .verifyOtp(code: code),
            completion: completion
        )
    }
    
    // MARK: - Generic Request Handler
    private func executeRequest<T: Decodable>(
        _ request: Request,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = request.url else {
            return completion(.failure(RequestError.invalidURL))
        }
        
        session.request(
            url,
            method: request.method,
            parameters: request.parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(request.headers)
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure:
                completion(.failure(self.mapError(from: response)))
            }
        }
    }
    
    private func mapError<T>(from response: AFDataResponse<T>) -> Error {
        if let data = response.data {
            return APIError(data: data)
        }
        
        guard let statusCode = response.response?.statusCode else {
            return RequestError.unknownServerError
        }
        
        switch statusCode {
        case 400: return RequestError.badRequest
        case 401: return RequestError.unauthorized
        case 403: return RequestError.forbidden
        case 404: return RequestError.notFound
        case 429: return RequestError.rateLimited
        case 500...599: return RequestError.serverError
        default: return RequestError.unknownServerError
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

