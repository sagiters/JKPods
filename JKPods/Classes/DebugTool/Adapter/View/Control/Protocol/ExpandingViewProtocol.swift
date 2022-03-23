//
//  ExpandingViewProtocol.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/5/6.
//

import UIKit

public typealias ExpandingView = UIView & ExpandingViewProtocol

public protocol ExpandingViewProtocol {
    func expandingViewInitialize()
    func expandingViewExpanded()
}
