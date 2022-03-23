//
//  ControlButton.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/1/24.
//

import Foundation
import UIKit

public class ControlButton {

    public static let shared = ControlButton()

    // MARK: - UI
    let floatButton: UIButton = UIButton()
    var buttonFloatingOn: UIView?
    var viewToExpand: ControlExpandableView = ControlExpandableView()

    // MARK: - Parameters
    var lastPosition: CGPoint = CGPoint.zero

    // MARK: - Initializers
    private func initFloatButton(viewToExpand: ExpandingView? = nil) {
        self.floatButton.frame = CGRect(x: self.lastPosition.x, y: self.lastPosition.y, width: ControlConfiguration.shared.buttonSize.width, height: ControlConfiguration.shared.buttonSize.height)

        self.floatButton.layer.cornerRadius = ControlConfiguration.shared.buttonSize.width / 2 // 10.0
        self.floatButton.layer.masksToBounds = true
        self.floatButton.backgroundColor = UIColor.init(red: 61/255.0, green: 26/255.0, blue: 37/255.0, alpha: 0.8)

        self.floatButton.addTarget(self, action: #selector(floatButtonTapped), for: .touchUpInside)

        self.floatButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:))))

        if self.lastPosition.x == 0.0 {
            self.lastPosition = CGPoint(x: ControlConfiguration.shared.buttonSize.width / 2.0 + ControlConfiguration.shared.padding,
                                        y: (self.buttonFloatingOn?.frame.size.height ?? ControlConfiguration.shared.buttonSize.width) / 2.0)
        }
        self.floatButton.center = self.lastPosition

        self.viewToExpand = ControlExpandableView(frame: self.buttonFloatingOn?.frame ?? CGRect.zero, expandMinFrame: self.floatButton.frame, viewToExpand: viewToExpand)

        self.buttonFloatingOn?.addSubview(self.viewToExpand)
    }

    // MARK: - Public methods
    public func enableFloating(onView: UIView?, viewToExpand: ExpandingView? = nil) {
        self.buttonFloatingOn = onView
        onView?.addSubview(self.floatButton)

        self.initFloatButton(viewToExpand: viewToExpand)
    }

    // MARK: - Actions
    @objc func floatButtonTapped() {

        self.viewToExpand.expand(floatButton: self.floatButton)
    }

    @objc func panHandler(_ gesture: UIPanGestureRecognizer) {

        if let gestureView = gesture.view, let floatSuperView = self.buttonFloatingOn {

            let topLimit: CGFloat = (ControlConfiguration.shared.buttonSize.height / 2.0) + ControlConfiguration.shared.padding
            let bottomLimit: CGFloat = (floatSuperView.frame.size.height - topLimit)
            let leftLimit: CGFloat = ((ControlConfiguration.shared.buttonSize.width / 2.0) + ControlConfiguration.shared.padding)
            let rightLimit: CGFloat = (floatSuperView.frame.size.width - leftLimit)

            let translation = gesture.translation(in: gestureView)
            let lastLocation = self.floatButton.center

            var newX = lastLocation.x + translation.x
            var newY = lastLocation.y + translation.y

            newX = newX >= 0.0 ? newX : 0.0
            newX = newX <= floatSuperView.frame.size.width ? newX : floatSuperView.frame.size.width

            newY =  newY >= 0.0 ? newY : 0.0
            newY = newY <= floatSuperView.frame.size.height ? newY : floatSuperView.frame.size.height

            if gesture.state == UIGestureRecognizer.State.ended {

                newX = newX < (floatSuperView.frame.size.width / 2.0) ? leftLimit : rightLimit

                UIView.animate(withDuration: 0.2) {
                    self.floatButton.center = CGPoint(x: newX, y: newY)
                }
            } else {
                self.floatButton.center = CGPoint(x: newX, y: newY)
            }

            self.lastPosition = self.floatButton.center
            gesture.setTranslation(CGPoint.zero, in: gestureView)
        }
    }

}
