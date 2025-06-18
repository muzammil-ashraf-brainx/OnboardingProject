//
//  DefaultAuthRepository.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import Foundation

// MARK: - DefaultAuthRepository

class DefaultAuthRepository: AuthRepository {
    func verifyOtp(otpParams: [String : Any], completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        performRequest(
            endpoint: "verify_otp",
            requestBody: otpParams,
            completion: completion
        )    }
    
    
    // MARK: - Signup
    
    func signup(signupRequestParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        performRequest(
            endpoint: "signup",
            requestBody: signupRequestParams,
            completion: completion
        )
    }
    
    // MARK: - Forget-Password
    func resetPassword(resetParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        performRequest(
            endpoint: "forgot_password",
            requestBody: resetParams,
            completion: completion
        )
    }

    
    // MARK: - Login
    
    func login(loginRequestParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        performRequest(
            endpoint: "login",
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
        guard let url = URL(string: "https://enpak-dev.brainxdemo.com/api/v1/auth/\(endpoint)") else {
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

