//
//  APIError.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidRequest
    case invalidResponse
}
