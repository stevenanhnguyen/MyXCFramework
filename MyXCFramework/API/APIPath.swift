//
//  APIPath.swift
//  MyXCFramework
//
//  Created by TuNA on 23/06/2023.
//

import Foundation

public enum APIPath: String {
    case login = "/login"
    case register = "/register"
    case changePassword = "/change_password"
    case forgotPassword = "/forgot_password"
    
    case getUserInfo = "get_user_info"
    
    case unknown = ""
}
