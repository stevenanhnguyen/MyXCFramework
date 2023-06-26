//
//  UserAuthentication.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public struct User: Codable {
    public let username: String
    public let password: String
}

public struct LoginResponse: Codable {
    public let token: String
    public let user: User
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
