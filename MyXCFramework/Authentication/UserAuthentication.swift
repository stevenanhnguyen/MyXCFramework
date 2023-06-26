//
//  UserAuthentication.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public struct LoginRequest: Encodable {
    public let email: String
    public let password: String
}

public struct LoginResponse: Decodable {
    public let success: Bool
    public let message: String
    public let data: LoginData
}

public struct LoginData: Decodable {
    public let token: String
    public let email: String
}

public class UserAuthentication {
    private let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func login(username: String, password: String, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        let endpoint = APIPath.login
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        apiClient.post(endpoint: endpoint, parameters: parameters) { (result: Result<APIResponse<LoginResponse>, APIError>) in
            switch result {
            case .success(let response):
                if let loginResponse = response.data {
                    completion(.success(loginResponse))
                } else {
                    completion(.failure(.invalidResponse))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    public func register(username: String, password: String, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        let endpoint = APIPath.register
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        apiClient.post(endpoint: endpoint, parameters: parameters) { (result: Result<LoginResponse, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
