//
//  UserInfo.swift
//  MyXCFramework
//
//  Created by TuNA on 10/07/2023.
//

import Foundation

public struct UserInfoResponse: Decodable {
    let id: String
    let name: String
    let email: String
    let emailVerifiedAt: String
    let currentTeamId: String
    let profilePhotoPath: String
    let createdAt: String
    let updatedAt: String
    let profilePhotoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case emailVerifiedAt = "email_verified_at"
        case currentTeamId = "current_team_id"
        case profilePhotoPath = "profile_photo_path"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profilePhotoUrl = "profile_photo_url"
    }
}

struct GetUserInfoAPI: API {
    var baseUrl: BaseURL { .dev }
    var path: APIPath { .getUserInfo }
    var parameters: Parameters?
    var method: HTTPMethod { .get }
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
              completion: @escaping (UserInfoResponse?) -> Void) {
        send(of: UserInfoResponse.self, queue: queue, decoder: decoder) { response, error in
            if let response = response {
                completion(response.data)
            } else if let error = error {
                completion(nil)
            }
        }
    }
}

public class UserInfo {
    
    public init() { }
    
    public func getUserInfo(completion: @escaping (UserInfoResponse?, APIError?) -> Void) {
        let param: Parameters = [:]
        GetUserInfoAPI(params: param).send { [weak self] data in
            guard let data = data else {
                let error = APIError.invalidResponse
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
    }
}
