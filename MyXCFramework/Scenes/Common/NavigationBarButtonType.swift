//
//  NavigationBarButtonType.swift
//  MyXCFramework
//
//  Created by TuNA on 11/07/2023.
//

import Foundation

/// The type of button placed on the navigation bar.
enum NavigationBarButtonType: Int, CaseIterable {
    /// None.
    case none
    /// Back button.
    case back
    /// Close (x) button.
    case close
    /// Post Button without border and background
    case post
    /// Post Button with border and background
    case createComment
    /// Close and pop to rootview
    case commentSuggest
}
