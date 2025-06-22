//
//  DefaultAuthRepository.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import Foundation

class DefaultAuthRepository: AuthRepository {
    
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
    
    private func executeRequest<T: Decodable>(
        _ requestType: Request,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        do {
            let request = try requestType.getURLRequest()
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    return completion(.failure(error))
                }
                
                guard let data = data else {
                    return completion(.failure(RequestError.noData))
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    return completion(.failure(APIError(data: data)))
                }
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
                
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
}

extension DefaultAuthRepository {
    
    enum Request {
        case signup(username: String, email: String, password: String, confirmPassword: String)
        case login(username: String, password: String)
        
        var url: URL? {
            switch self {
            case .signup:
                return URL(string: Environment.baseURL + APIEndpoints.Auth.signup)
            case .login:
                return URL(string: Environment.baseURL + APIEndpoints.Auth.login)
            }
        }
        
        var method: HTTPMethod { .post }
        
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
            }
        }
        
        func getURLRequest() throws -> URLRequest {
            guard let url = url else {
                throw RequestError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            
            headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
            
            return request
        }
    }
    
}
