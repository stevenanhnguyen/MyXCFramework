//
//  APIResponse.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    public let success: Bool
    public let message: String
    public let data: T?
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
}

