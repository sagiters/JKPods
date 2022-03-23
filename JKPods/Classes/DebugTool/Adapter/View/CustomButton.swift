//
//  CustomButton.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/5/6.
//

import UIKit

class CustomButton<T: Hashable>: UIButton {
    let title: String
    let imageName: String
    let action: (() -> Void)?
    let subLayerKey: T?
    var startPoint: CGPoint?

    init(title: String, imageName: String, action: (() -> Void)?, subLayerKey: T? = nil) {
        self.title = title
        self.imageName = imageName
        self.action = action
        self.subLayerKey = subLayerKey
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeDistance(_ startPoint: CGPoint) {
        self.startPoint = startPoint
        let endPoint: CGPoint = self.center
        self.alpha = 0
        self.center = startPoint
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
            self.center = endPoint
        }
    }

    func fadeIn() {
        self.alpha = 0
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = 1.0
        } completion: { (success) in

        }
    }

    func fadeOut() {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = 0.0
        } completion: { (success) in

        }
    }

    func hideAnimation() {
        if let startPoint = startPoint {
            UIView.animate(withDuration: 0.3) {
                self.alpha = 0.0
                self.center = startPoint
            }
        } else {
            fadeOut()
        }
    }
}
