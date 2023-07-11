//
//  BaseViewController.swift
//  MyXCFramework
//
//  Created by TuNA on 11/07/2023.
//

import Foundation

import UIKit

public class BaseViewController: UIViewController {
    
    var isLoadingState: Bool? {
        didSet {
            isLoadingState == true ? showProgress() : hideProgress()
        }
    }
    
    var errorMessage: Error? {
        didSet {
            handleErrorMessage()
        }
    }
    
    var hudShowCount: Int = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindingProgress()
        bindingError()
    }
    
    // MARK: - Binding Show Hide Progress
    
    private func bindingProgress() {
        // TODO: binding Progress
        
    }
    
    private func showProgress() {
        if hudShowCount == 0 {
            // Show native iOS activity indicator
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        hudShowCount += 1
    }
    
    private func hideProgress() {
        guard hudShowCount > 0 else { return }
        hudShowCount -= 1
        if hudShowCount == 0 {
            // Hide native iOS activity indicator
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func forceHideProgress() {
        // Hide native iOS activity indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - Handle Show Error from Server
    private func bindingError() {
        // TODO: binding Error
        
    }
    
    private func handleErrorMessage() {
        // TODO: binding Error message
        
    }
}

// MARK: - Setup Navigation Item
extension BaseViewController {
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    /// ナビゲーションバーを非表示にする.
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// Set Title Navigation bar
    func setNavigationBar(title: String) {
        navigationItem.title = title
    }
    
    /// Dissmiss Viewcontroller
    /// - Parameter animated: Animation if needed
    @objc func clickCloseButton(_ sender : Any?) -> Void{
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    /// Pop to root Viewcontroller
    /// - Parameter animated: Animation if needed
    @objc func clickCloseCommentSuccessButton(_ sender : Any?) -> Void{
        self.view.endEditing(true)
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func clickPostButton(_ sender : Any?) -> Void{
        
        
    }
    
    /// Pop to previous ViewController
    @objc func clickBackButton(_ sender : Any?) -> Void {
        navigationController?.popViewController(animated: true)
    }

    /// Navigation bar Left BarButtonItem setting.
    ///
    /// - Parameter type: BarButtonItem type.
    /// - Parameter selector: Left bar button processing when pressed.
    func setLeftBarButton(type: NavigationBarButtonType) {
        switch type {
        case .none:
            navigationItem.hidesBackButton = true
        case .back:
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "back_icon.pdf"), for: .normal)
            button.addTarget(self, action: #selector(self.clickBackButton(_:)), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = barButton
        case .close:
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "close_icon"), for: .normal)
            button.addTarget(self, action: #selector(self.clickCloseButton(_:)), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = barButton
        case .post:
            let button = UIButton(type: .custom)
            button.setTitle("TEXT", for: .normal)
            button.setTitleColor(Resource.Color.alto, for: .normal)
            button.addTarget(self, action: #selector(self.clickCloseButton(_:)), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = barButton
        case .createComment:
            let button = UIButton(type: .custom)
            button.setTitle("TEXT", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = Resource.Color.bombay
            button.layer.cornerRadius = 15
            button.titleLabel?.font = UIFont(name: "RobotoFont", size: 12)
            button.contentEdgeInsets = UIEdgeInsets(top: 5,left: 10,bottom: 5,right: 10)
            button.addTarget(self, action: #selector(self.clickCloseButton(_:)), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = barButton
        case .commentSuggest:
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "close_icon"), for: .normal)
            button.addTarget(self, action: #selector(self.clickCloseCommentSuccessButton(_:)), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = barButton
        }
    }

    /// Navigation bar Right BarButtonItem setting.
    ///
    /// - Parameter type: BarButtonItem type.
    /// - Parameter selector: Right bar button processing when pressed.
    func setRightBarButton(type: NavigationBarButtonType, selector: Selector? = nil) {
        switch type {
        case .none,
             .back,
             .commentSuggest:
            assertionFailure()
        case .close:
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "close_icon"), for: .normal)
            button.addTarget(self, action: #selector(self.clickCloseButton(_:)), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = barButton
        case .post:
            let button = UIButton(type: .custom)
            button.setTitle("TEXT", for: .normal)
            button.titleLabel?.font = RobotoFont.bold(with: 14)
            button.setTitleColor(Resource.Color.alto, for: .normal)
            button.addTarget(self, action: #selector(self.clickPostButton(_:)), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = barButton
        case .createComment:
            let button = UIButton(type: .custom)
            button.setTitle("TEXT", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = Resource.Color.bombay
            button.layer.cornerRadius = 15
            button.titleLabel?.font = UIFont(name: "RobotoFont", size: 12)
            button.contentEdgeInsets = UIEdgeInsets(top: 5,left: 10,bottom: 5,right: 10)
            button.addTarget(self, action: #selector(self.clickCloseButton(_:)), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = barButton
        }
    }
}
