//
//  APIClient.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]
let TimeoutDefault: TimeInterval = 30

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum BaseURL: String {
    case dev = "https://hnc-admin.mk1technology.vn/api"
}

protocol API {
    var baseURL: BaseURL { get }
    var path: APIPath { get }
    var parameters: Parameters? { get }
    var expandPath: String? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

extension API {
    var baseURL: BaseURL { return .dev }
    var path: APIPath { return .unknown }
    var parameters: Parameters? { return nil }
    var expandPath: String? { return nil }
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders? { return nil }
}

struct HeaderValue {
    static let applicationJson = "application/json"
    static let applicationFormData = "application/x-www-form-urlencoded"
}

struct HeaderKey {
    static let Accept              = "Accept"
    static let ContentType         = "Content-Type"
    static let Authorization       = "Authorization"
}

extension API {
    func request<T: Decodable>(of type: T.Type = T.self,
                               queue: DispatchQueue = .main,
                               decoder: JSONDecoder = JSONDecoder(),
                               timeout: TimeInterval = TimeoutDefault,
                               showPopup: Bool = true,
                               completion: @escaping (T?, Error?) -> Void) {
        let url = URL(string: baseURL.rawValue + path.rawValue)!
        print("URL", url)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(HeaderValue.applicationJson, forHTTPHeaderField: HeaderKey.ContentType)
        
        if let parameters = parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            } catch {
                completion(nil, error)
                return
            }
        }
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, APIError.invalidResponse)
                return
            }
            
            log(responseData: data, response: response)
            do {
                let result = try decoder.decode(T.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func send<T: Decodable>(of type: T.Type = T.self,
                            queue: DispatchQueue = .main,
                            decoder: JSONDecoder = JSONDecoder(),
                            timeout: TimeInterval = TimeoutDefault,
                            showPopup: Bool = true,
                            completion: @escaping (APIResponse<T>?, Error?) -> Void) {
        request(of: APIResponse<T>.self, queue: queue, decoder: decoder, timeout: timeout, showPopup: showPopup) { response, error in
            if let response = response {
                completion(response, nil)
            } else if let error = error {
                completion(nil, error)
            } else {
                completion(nil, APIError.invalidResponse)
            }
        }
    }
    
    public func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            print("responseData: \(String(describing: dataDict))")
        }
    }
}

extension Dictionary where Key == String, Value == Any {
    mutating func addParam(_ key: String, value: Value?) {
        if let valueObj = value {
            updateValue(valueObj, forKey: key)
        }
    }
}

extension HTTPHeaders {
    mutating func add(name: String, value: String) {
        self[name] = value
    }
    
    mutating func addAccept() {
        add(name: HeaderKey.Accept, value: HeaderValue.applicationJson)
    }
    
    mutating func addAuthorization() {
        let value = "Bearer " + (SessionManager.shared.getToken() ?? "")
        add(name: HeaderKey.Authorization, value: value)
    }
    
    mutating func addContentType() {
        add(name: HeaderKey.ContentType, value: HeaderValue.applicationFormData)
    }
}
