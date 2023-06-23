//
//  UserAuthentication.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public class APIManager {
    
    public static let shared = APIManager()
    
    private init() {}
    
    public func sendRequest(url: String, method: HTTPMethod, parameters: [String: Any]?, completion: @escaping (Data?, Error?) -> Void) {
        guard let requestUrl = URL(string: url) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(nil, error)
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        
        // Set parameters
        if let parameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
}

public class UserAuthentication {
    
    private let apiManager: APIManager
    
    public init() {
        apiManager = APIManager.shared
    }
    
    public func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let url = ""
        let parameters = [
            "username": username,
            "password": password
        ]
        
        apiManager.sendRequest(url: url, method: .post, parameters: parameters) { (data, error) in
            // TO DO: parse data
            
        }
    }
    
    public func register(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let url = ""
        let parameters = [
            "username": username,
            "password": password
        ]
        
        apiManager.sendRequest(url: url, method: .post, parameters: parameters) { (data, error) in
            // TO DO: parse data
            
            
        }
    }
    
    public func forgotPassword(email: String, completion: @escaping (Bool, Error?) -> Void) {
        let url = ""
        let parameters = [
            "email": email
        ]
        
        apiManager.sendRequest(url: url, method: .post, parameters: parameters) { (data, error) in
            // TO DO: parse data
            
            
        }
    }
    
    public func logout(completion: @escaping (Bool, Error?) -> Void) {
        let url = ""
        apiManager.sendRequest(url: url, method: .get, parameters: nil) { (data, error) in
            // TO DO: parse data
            
            
        }
    }
}

