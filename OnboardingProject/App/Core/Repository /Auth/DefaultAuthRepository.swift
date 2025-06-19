//
//  DefaultAuthRepository.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import Foundation

class DefaultAuthRepository: AuthRepository {
    
    // MARK: - Signup
    func signup(signupRequestParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        performRequest(
            endpoint: APIEndpoints.Auth.signup,
            requestBody: signupRequestParams,
            completion: completion
        )
    }
    
    // MARK: - Login
    func login(loginRequestParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        performRequest(
            endpoint: APIEndpoints.Auth.login,
            requestBody: loginRequestParams,
            completion: completion
        )
    }
    
    // MARK: - Shared Request Logic
    private func performRequest(
        endpoint: String,
        requestBody: [String: Any],
        completion: @escaping (Result<SignupResponse, Error>) -> Void
    ) {
        let urlString = Environment.baseURL + endpoint
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            urlRequest.httpBody = jsonData
            print("MARK: \(endpoint.capitalized) Request Body: \(String(data: jsonData, encoding: .utf8) ?? "")")
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid HTTP Response", code: -1)))
                return
            }
            
            print("MARK: \(endpoint.capitalized) Status Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let serverMessage = String(data: data ?? Data(), encoding: .utf8) ?? "Unknown server error"
                let error = NSError(domain: serverMessage, code: httpResponse.statusCode)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(SignupResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
      
