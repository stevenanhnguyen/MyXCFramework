//
//  APIClient.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public class APIClient {
    private let baseURL = "https://mk1technology.com"
    
    public init() {}
    
    public func post(endpoint: APIPath, parameters: [String: Any], completion: @escaping (Result<APIResponse, APIError>) -> Void) {
        let requestURL = URL(string: baseURL + endpoint.path)!
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        // TO DO: Set request headers if needed
        
    
        // Set request body
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        // Perform the network request using URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            // TO DO: Handle response and errors
            
            
        }.resume()
    }
    
    public func get(endpoint: APIPath, completion: @escaping (Result<APIResponse, APIError>) -> Void) {
        let requestURL = URL(string: baseURL + endpoint.path)!
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // TO DO: Handle response and errors
            
            
        }.resume()
    }

    
    public func authenticate(username: String, password: String, completion: @escaping (Result<AuthenticationToken, AuthenticationError>) -> Void) {
        // TO DO:
        
        
    }
}
