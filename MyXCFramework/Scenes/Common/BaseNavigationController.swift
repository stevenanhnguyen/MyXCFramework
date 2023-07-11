//
//  BaseNavigationController.swift
//  MyXCFramework
//
//  Created by TuNA on 11/07/2023.
//

import UIKit

/// BaseNavigationController
final class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {}
