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

struct UserAuthentication: API {
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

public class UserAuthenClass {
    
    public init() { }
    
    public func login(email: String, password: String, completion: @escaping (LoginResponse?, APIError?) -> Void) {
        var param: Parameters = [:]
        param.addParam("email", value: email)
        param.addParam("password", value: password)
        
        UserAuthentication(params: param).send { [weak self] memberInfo in
            guard let data = memberInfo else {
                let error = APIError.invalidResponse
                completion(nil, error)
                return
            }
            
            completion(data, nil)
        }
    }
}


