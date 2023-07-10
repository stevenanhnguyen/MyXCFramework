//
//  UserAuthentication.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public struct LoginResponse: Decodable {
    let token: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case token
        case email
    }
}

struct LoginAPI: API {
    var baseUrl: BaseURL { .dev }
    var path: APIPath { .login }
    var parameters: Parameters?
    var method: HTTPMethod { .post }
    var headers: HTTPHeaders? {
        let headers = HTTPHeaders()
        
        return headers
    }
    
    init(params: Parameters? = nil) {
        parameters = params
    }
    
    func send(queue: DispatchQueue = .main,
              decoder: JSONDecoder = JSONDecoder(),
              completion: @escaping (LoginResponse?) -> Void) {
        send(of: LoginResponse.self, queue: queue, decoder: decoder) { response, error in
            if let response = response {
                completion(response.data)
            } else if let error = error {
                completion(nil)
            }
        }
    }
}

public struct RegisterResponse: Decodable {
    let name: String
    let email: String
    let updatedAt: String
    let createdAt: String
    let id: Int
    let profilePhotoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case profilePhotoUrl = "profile_photo_url"
    }
}

struct RegisterAPI: API {
    var baseUrl: BaseURL { .dev }
    var path: APIPath { .register }
    var parameters: Parameters?
    var method: HTTPMethod { .post }
    var headers: HTTPHeaders? {
        let headers = HTTPHeaders()
        return headers
    }
    
    init(params: Parameters? = nil) {
        parameters = params
    }
    
    func send(queue: DispatchQueue = .main,
              decoder: JSONDecoder = JSONDecoder(),
              completion: @escaping (RegisterResponse?) -> Void) {
        send(of: RegisterResponse.self, queue: queue, decoder: decoder) { response, error in
            if let response = response {
                completion(response.data)
            } else if let error = error {
                completion(nil)
            }
        }
    }
}

public struct ForgotPasswordResponse: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct ForgotPasswordAPI: API {
    var baseUrl: BaseURL { .dev }
    var path: APIPath { .forgotPassword }
    var parameters: Parameters?
    var method: HTTPMethod { .post }
    var headers: HTTPHeaders? {
        let headers = HTTPHeaders()
        return headers
    }
    
    init(params: Parameters? = nil) {
        parameters = params
    }
    
    func send(queue: DispatchQueue = .main,
              decoder: JSONDecoder = JSONDecoder(),
              completion: @escaping (ForgotPasswordResponse?) -> Void) {
        send(of: ForgotPasswordResponse.self, queue: queue, decoder: decoder) { response, error in
            if let response = response {
                completion(response.data)
            } else if let error = error {
                completion(nil)
            }
        }
    }
}

public struct ChangePasswordResponse: Decodable {
    let id: String
    let profilePhotoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case profilePhotoUrl = "profile_photo_url"
    }
}

struct ChangePasswordAPI: API {
    var baseUrl: BaseURL { .dev }
    var path: APIPath { .changePassword }
    var parameters: Parameters?
    var method: HTTPMethod { .post }
    var headers: HTTPHeaders? {
        var headers = HTTPHeaders()
        headers.addAuthorization()
        return headers
    }
    
    init(params: Parameters? = nil) {
        parameters = params
    }
    
    func send(queue: DispatchQueue = .main,
              decoder: JSONDecoder = JSONDecoder(),
              completion: @escaping (ChangePasswordResponse?) -> Void) {
        send(of: ChangePasswordResponse.self, queue: queue, decoder: decoder) { response, error in
            if let response = response {
                completion(response.data)
            } else if let error = error {
                completion(nil)
            }
        }
    }
}

public class UserAuthentication {
    
    public init() { }
    
    public func login(email: String, password: String, completion: @escaping (LoginResponse?, APIError?) -> Void) {
        var param: Parameters = [:]
        param.addParam("email", value: email)
        param.addParam("password", value: password)
        
        LoginAPI(params: param).send { [weak self] data in
            guard let data = data else {
                let error = APIError.invalidResponse
                completion(nil, error)
                return
            }
            GlobalDataHandler.sharedToken = data.token
            completion(data, nil)
        }
    }
    
    public func register(name: String, email: String,
                         password: String, pwConfirmation: String,
                         completion: @escaping (RegisterResponse?, APIError?) -> Void) {
        var param: Parameters = [:]
        param.addParam("name", value: name)
        param.addParam("email", value: email)
        param.addParam("password", value: password)
        param.addParam("password_confirmation", value: pwConfirmation)
        RegisterAPI(params: param).send { [weak self] data in
            guard let data = data else {
                let error = APIError.invalidResponse
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
    }
    
    public func forgotPassword(email: String, completion: @escaping (ForgotPasswordResponse?, APIError?) -> Void) {
        var param: Parameters = [:]
        param.addParam("email", value: email)
        ForgotPasswordAPI(params: param).send { [weak self] data in
            guard let data = data else {
                let error = APIError.invalidResponse
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
    }
    
    public func changePassword(password: String, pwConfirmation: String, completion: @escaping (ChangePasswordResponse?, APIError?) -> Void) {
        var param: Parameters = [:]
        param.addParam("new_password", value: password)
        param.addParam("confirm_new_password", value: pwConfirmation)
        ChangePasswordAPI(params: param).send { [weak self] data in
            guard let data = data else {
                let error = APIError.invalidResponse
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
    }
    
    public func logout() {
        GlobalDataHandler.sharedToken = ""
    }
}

