//
//  ControlExpandableView.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/1/24.
//

import Foundation
import UIKit

class ControlExpandableView: UIView {

    // MARK: - UI
    var expandingView: ExpandingView?

    // MARK: - Parameters
    var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var minExpandFrame = CGRect.zero, maxExpandFrame = CGRect.zero

    // MARK: - Initializers
    convenience init() {
        self.init(frame: CGRect.zero, expandMinFrame: CGRect.zero)
    }

    init(frame: CGRect, expandMinFrame: CGRect, viewToExpand: ExpandingView? = nil) {
        super.init(frame: frame)

        self.minExpandFrame = expandMinFrame

        var ratio: CGFloat = 1.0

        let newWidth = self.frame.size.width - (self.contentInsets.left + self.contentInsets.right)
        let newHeight = newWidth / ratio

        self.maxExpandFrame = CGRect(x: self.contentInsets.left, y: self.contentInsets.top, width: newWidth, height: newHeight)

        if let expandingView = viewToExpand {
            self.expandingView = expandingView
            expandingView.center = self.center
        }

        // TODO: Default view
//        else {
//            self.expandingView = UIView(frame: expandMinFrame)
//        }

        self.expandingView?.alpha = 0.8
//        self.expandingView?.backgroundColor = .gray
        self.expandingView?.layer.cornerRadius = 30.0
        self.expandingView?.layer.masksToBounds = true
//        self.expandingView?.autoresizesSubviews = true

        if let expandingView = expandingView {
            self.addSubview(expandingView)
        }
        self.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.collapse()
    }

    // MARK: - Public methods
    func expand(floatButton: UIButton) {

        self.isHidden = false

        floatButton.isHidden = true

        self.minExpandFrame = floatButton.frame
        self.expandingView?.frame = floatButton.frame

        UIView.animate(withDuration: 0.2) {
            self.expandingView?.frame = self.maxExpandFrame
            self.expandingView?.center = self.center
        }

//        if let circleMenu = self.expandingView as? CircleMenu {
//            circleMenu.commonInit()
//        }
        self.expandingView?.expandingViewInitialize()

        UIView.animate(withDuration: 0.2) {
            self.expandingView?.frame = self.maxExpandFrame
            self.expandingView?.center = self.center
        } completion: { (success) in
            self.expandingView?.expandingViewExpanded()
        }

    }

    func collapse() {

        UIView.animate(withDuration: 0.2) {
            self.expandingView?.frame = self.minExpandFrame
        } completion: { (success) in

            ControlButton.shared.floatButton.isHidden = false

            self.isHidden = true
        }

    }
}
