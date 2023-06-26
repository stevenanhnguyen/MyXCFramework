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

public struct UserAuthenticationResponse: Codable {
    public let token: String
    public let user: User
}

public protocol APIClientProtocol {
    func post(endpoint: String, parameters: [String: Any], completion: @escaping (Result<UserAuthenticationResponse, MyXCFramework.APIError>) -> Void)
    func get(endpoint: String, parameters: [String: Any], completion: @escaping (Result<UserAuthenticationResponse, MyXCFramework.APIError>) -> Void)
}

public class UserAuthentication {
    private let apiClient: APIClientProtocol

    public init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    public func login(user: User, completion: @escaping (Result<UserAuthenticationResponse, MyXCFramework.APIError>) -> Void) {
        let endpoint = "/login"
        let parameters: [String: Any] = [
            "username": user.username,
            "password": user.password
        ]
        
        apiClient.post(endpoint: endpoint, parameters: parameters) { result in
            completion(result)
        }
    }
    
    public func getUserInfo(completion: @escaping (Result<UserAuthenticationResponse, MyXCFramework.APIError>) -> Void) {
        let endpoint = "/user/info"
        
        apiClient.get(endpoint: endpoint, parameters: [:]) { result in
            completion(result)
        }
    }
}
