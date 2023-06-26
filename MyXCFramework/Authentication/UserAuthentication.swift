//
//  UserAuthentication.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

struct User {
    let username: String
    let password: String
}

class AuthManager {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func login(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let parameters = [
            "username": user.username,
            "password": user.password
        ]
        
        apiClient.post(endpoint: .login, parameters: parameters) { result in
            switch result {
            case .success:
                // Login successful
                completion(.success(()))
            case .failure(let error):
                // Login failed
                completion(.failure(error))
            }
        }
    }
    
    func register(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let parameters = [
            "username": user.username,
            "password": user.password
        ]
        
        apiClient.post(endpoint: .register, parameters: parameters) { result in
            switch result {
            case .success:
                // Registration successful
                completion(.success(()))
            case .failure(let error):
                // Registration failed
                completion(.failure(error))
            }
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        apiClient.get(endpoint: .logout) { result in
            switch result {
            case .success:
                // Logout successful
                completion(.success(()))
            case .failure(let error):
                // Logout failed
                completion(.failure(error))
            }
        }
    }
}
