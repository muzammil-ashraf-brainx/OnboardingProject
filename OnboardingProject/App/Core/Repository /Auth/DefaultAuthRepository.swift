//import Foundation
//
//class DefaultAuthRepository: AuthRepository {
//    func signup(signupRequestParams: [String: Any], completion: @escaping (Result<SignupResponse, Error>) -> Void) {
//        
//        guard let url = URL(string: "https://enpak-dev.brainxdemo.com/api/v1/auth/signup") else {
//            let error = NSError(domain: "Invalid URL", code: -1)
//            completion(.failure(error))
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let hardcodedData = [
//            "username": "muzaa",
//            "email": "muzaa@mailinator.com",
//            "password": "12345678",
//            "confirmPassword": "12345678"
//        ]
//        
//        do { // try all use cases with or without optional
//            let jsonData = try JSONSerialization.data(withJSONObject: hardcodedData, options: []) // why we do that
//            urlRequest.httpBody = jsonData
//        } catch {
//            completion(.failure(error)) // from where this error is coming?
//            return
//        }
//
//        // how URL session works
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//                    if let error = error {
//                        completion(.failure(error))
//                        return
//                    }
//            
//            if let response = response as? HTTPURLResponse {
//                print("Status code: \(response.statusCode)")
//            }
//            
//            if let data = data,
//               let dataString = String(data: data, encoding: .utf8) { //How this syntax working
//                print("Response data string: \(dataString)")
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "No data", code: -1))) // why passing -1 in code
//                return
//            }
//
//            do {
//                let decoded = try JSONDecoder().decode(SignupResponse.self, from: data) // why decoding? and what is the mean or purpose of  "SignupResponse.self"
//                completion(.success(decoded))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume() // what is the purpose of resume?
//    }
//}
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
        
        // Convert request params to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: signupRequestParams, options: [])
            urlRequest.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        // MARK: - Perform Network Call
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
            }
            
            if let data = data,
               let dataString = String(data: data, encoding: .utf8) {
                print("Response data string: \(dataString)")
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "No data", code: -1)
                completion(.failure(noDataError))
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
