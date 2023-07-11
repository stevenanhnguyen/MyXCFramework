//
//  SessionManager.swift
//  MyXCFramework
//
//  Created by TuNA on 11/07/2023.
//

import Foundation

class SessionManager {
    
    //MARK: Setup
    static let shared = SessionManager()
    private let defaults = Defaults.shared
    
    //MARK: Varidate
    var token: String? { return self.getToken() }
    
    //MARK: Config
    func setToken(token: String) {
        self.defaults.set(token, for: DefaultsKey.TOKEN_AUTH)
    }
    
    func getToken() -> String? {
        self.defaults.get(for: DefaultsKey.TOKEN_AUTH)
    }
    
    func setDeviceToken(token: String) {
        self.defaults.set(token, for: DefaultsKey.DEVICE_TOKEN)
    }
    
    func getDeviceToken() -> String? {
        self.defaults.get(for: DefaultsKey.DEVICE_TOKEN)
    }
    
    func clearToken() {
        self.defaults.clear(DefaultsKey.TOKEN_AUTH)
    }
}

extension DefaultsKey {
    static let DEVICE_TOKEN                 = Key<String>("DEVICE_TOKEN")
    static let FCM_TOKEN                    = Key<String>("FCM_TOKEN")
    static let TOKEN_AUTH                   = Key<String>("TOKEN_AUTH")
}
