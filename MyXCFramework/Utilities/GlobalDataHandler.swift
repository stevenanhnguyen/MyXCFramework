//
//  GlobalDataHandler.swift
//  MyXCFramework
//
//  Created by TuNA on 10/07/2023.
//

import Foundation

class GlobalDataHandler {
    private static var instance: GlobalDataHandler?
    
    class func sharedInstance() -> GlobalDataHandler {
        if self.instance == nil {
            self.instance = GlobalDataHandler()
        }
        
        return self.instance!
    }
    
    private static var token: String = ""
    
    class var sharedToken: String {
        get {
            return token
        }
        set {
            token = newValue
        }
    }
    
}
