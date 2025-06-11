//
//  DefaultAuthRepository.swift
//  OnboardingProject
//
//  Created by BrainX iOS Dev on 16/05/2025.
//

import Foundation

// MARK: - DefaultAuthRepository

class DefaultAuthRepository: AuthRepository {
    
    // MARK: - Signup
    
    func signup(signupRequestParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        
        // MARK: - Prepare URL
        
        guard let url = URL(string: "https://enpak-dev.brainxdemo.com/api/v1/auth/signup") else {
            let error = NSError(domain: "Invalid URL", code: -1)
            completion(.failure(error))
            return
        }
        
        // MARK: - Prepare Request
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //        let hardcodedData = [
        //            "username": "muzasdssdsa",
        //            "email": "muzaddewefdsa@mailinator.com",
        //            "password": "12345678",
        //            "confirmPassword": "12345678"
        //        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: signupRequestParams, options: [])
            urlRequest.httpBody = jsonData
            print("MARK: Request JSON Body: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")
        } catch {
            completion(.failure(error))
            return
        }
        
        // MARK: - Perform Network Call
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            // Handle connection-level error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "Invalid HTTP Response", code: -1)
                completion(.failure(error))
                return
            }
            
            print("MARK: Status Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let serverMessage = String(data: data ?? Data(), encoding: .utf8) ?? "Unknown server error"
                let error = NSError(domain: serverMessage, code: httpResponse.statusCode)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data received", code: -1)
                completion(.failure(error))
                return
            }
            
            // MARK: - Decode Response
            
            do {
                let decoded = try JSONDecoder().decode(SignupResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
}

