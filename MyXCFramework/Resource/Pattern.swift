//
//  Pattern.swift
//  MyXCFramework
//
//  Created by TuNA on 11/07/2023.
//

import Foundation

extension Resource.Pattern {
    static let email = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
    static let password = "(?=.*[A-Z]).{8,}"
    static let specialChar  = ".*[^A-Za-z0-9].*"
    static let phone = "(?=.*[0-9]).{10,16}"
    static let onlyNumber = "^[0-9]*$"
    
    static let dayTime = "dd-MM-yyyy HH:mm:ss"
    static let yearTime = "yyyy-MM-dd"
    static let hourTime = "HH:mm:ss"
}
