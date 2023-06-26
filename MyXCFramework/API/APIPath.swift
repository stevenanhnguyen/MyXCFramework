//
//  APIPath.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public enum APIPath {
    case login
    case register
    case logout
    
    public var path: String {
        switch self {
        case .login:
            return "/login"
        case .register:
            return "/login"
        case .logout:
            return "/login"
        }
    }
}
