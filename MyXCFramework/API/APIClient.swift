//
//  APIClient.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public class APIClient {
    private let baseURL = "https://hnc-admin.mk1technology.vn/api"
    
    public init() {}
    
    public func post<T: Decodable>(endpoint: APIPath, parameters: [String: Any], completion: @escaping (Result<T, APIError>) -> Void) {
        let requestURL = URL(string: baseURL + endpoint.path)!
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        // Set request body
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        // Perform the network request using URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response and errors
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.networkError))
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                // Successful response
                let decoder = JSONDecoder()
                do {
                    let result: T = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            } else {
                // Error response
                completion(.failure(.networkError))
            }
        }.resume()
    }
    
    public func get<T: Decodable>(endpoint: APIPath, parameters: [String: Any], completion: @escaping (Result<T, APIError>) -> Void) {
        let requestURL = URL(string: baseURL + endpoint.path)!
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // Set request body
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        // Perform the network request using URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response and errors
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.networkError))
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                // Successful response
                let decoder = JSONDecoder()
                do {
                    let result: T = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            } else {
                // Error response
                completion(.failure(.networkError))
            }
        }.resume()
    }
}
