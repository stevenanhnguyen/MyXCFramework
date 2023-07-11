//
//  UIViewController+Extension.swift
//  MyXCFramework
//
//  Created by TuNA on 11/07/2023.
//

import Foundation
import UIKit

public extension UIViewController {
    func showLogin() {
        let storyboard = UIStoryboard(name: "LoginVC", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        guard let window = UIApplication.shared.keyWindow else { return }
        let navigationController = BaseNavigationController(rootViewController: viewController)
        viewController.view.alpha = 0.0
        window.rootViewController = navigationController
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { viewController.view.alpha = 1.0 },
                          completion: nil)
    }
    
    func showDashboard() {
        let storyboard = UIStoryboard(name: "DashboardVC", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DashboardVC")
        guard let window = UIApplication.shared.keyWindow else { return }
        let navigationController = BaseNavigationController(rootViewController: viewController)
        viewController.view.alpha = 0.0
        window.rootViewController = navigationController
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { viewController.view.alpha = 1.0 },
                          completion: nil)
    }
    
    func presentLogin() {
        let storyboard = UIStoryboard(name: "LoginVC", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        self.present(BaseNavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
}
