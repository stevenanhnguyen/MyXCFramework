//
//  LoginVC.swift
//  MyXCFramework
//
//  Created by TuNA on 11/07/2023.
//

import Foundation

public class LoginVC: BaseViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setLeftBarButton(type: .close)
        self.setNavigationBar(title: "Login View")
    }
    
}

extension LoginVC {
    /// Set up Navigation Bar
    private func setupNavigation() {
        self.showNavigationBar()
    }
}
