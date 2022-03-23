//
//  CircleMenu.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/1/28.
//

import Foundation
import UIKit

public class CircleMenu<Type: Hashable>: ExpandingView {
    public func expandingViewInitialize() {
        removeButtons()
        if let layerData = viewModel.menuData?.layer[viewModel.initialLayer] {
            self.viewModel.currentData = layerData
        }
    }

    public func expandingViewExpanded() {
        createButtons()
        showAnimation()
    }


    let viewModel: ControlViewModel<Type>

    lazy var backButton: UIButton = {
        let btn: UIButton = UIButton()
        btn.setTitle("Back", for: .normal)
        btn.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return btn
    }()

    var currentButtons: [CustomButton<Type>]? = []

    @IBInspectable open var startAngle: Float = -90
    /// End angle of the circle
    @IBInspectable open var endAngle: Float = 270

    public init(with viewModel: ControlViewModel<Type>) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.backgroundColor = UIColor.init(red: 61/255.0, green: 26/255.0, blue: 37/255.0, alpha: 1.0)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        print("frame: \(self.frame)")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInit() {
        removeButtons()
        if let layerData = viewModel.menuData?.layer[viewModel.initialLayer] {
            self.viewModel.currentData = layerData
        }
    }

    func createButtons() {

        guard let data = viewModel.currentData?.data else { return }

        let buttons = data.map { (item) -> CustomButton<Type> in
            CustomButton(title: item.name, imageName: item.imageName, action: item.action, subLayerKey: item.subLayerKey)

        }

        if let _ = viewModel.currentData?.superMenuLayer {
            addSubview(backButton)
            backButton.frame = CGRect(origin: CGPoint(x: bounds.width/2 - 30, y: bounds.width/2 - 30), size: CGSize(width: 60, height: 60))
        }

        let step = getArcStep()
        print("step: \(step)")
        for index in 0 ..< viewModel.buttonCount {

            let angle: Float = startAngle + Float(index) * step
            let buttonSize: CGSize = CGSize(width: 100.0, height: 100.0)

            let point: CGPoint = CGPoint.pointOnCircle(center: CGPoint(x: bounds.width/2, y: bounds.width/2), radius: CGFloat(100), angle: CGFloat(deg2rad(Double(angle))))

            let button = buttons[index]
            button.frame = CGRect(x: point.x - (buttonSize.width / 2), y: point.y - (buttonSize.height / 2), width: buttonSize.width, height: buttonSize.height)
            button.setTitle(button.title, for: .normal)
            button.alpha = 0.0
            button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
            addSubview(button)
            currentButtons?.append(button)
        }
    }

    func showAnimation(_ startPoint: CGPoint? = nil) {

        currentButtons?.forEach { (customButton) in
            if let startPoint = startPoint {
                customButton.changeDistance(startPoint)
            } else {
                customButton.fadeIn()
            }
        }

        UIView.animate(withDuration: 0.3) { [weak self] in
            if let _ = self?.viewModel.currentData?.superMenuLayer {
                self?.backButton.alpha = 1.0
            }
        } completion: { (success) in

        }

    }

    func removeButtons() {
        currentButtons?.forEach({ (btn) in
            btn.removeFromSuperview()
            backButton.removeFromSuperview()
        })
        currentButtons = []
    }

    fileprivate func getArcStep() -> Float {
        var arcLength = endAngle - startAngle
        var stepCount = viewModel.buttonCount

        if arcLength < 360 {
            stepCount -= 1
        } else if arcLength > 360 {
            arcLength = 360
        }

        return arcLength / Float(stepCount)
    }

    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }

    // MARK: - Actions
    @objc func handleButtonTapped(_ sender: Any) {

        guard let sender = sender as? CustomButton<Type> else { return }

        if let subLayerKey = sender.subLayerKey,
           let layerData = self.viewModel.menuData?.layer[subLayerKey] {

            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.currentButtons?.forEach({ (button) in
                    button.alpha = 0
                })
                self?.backButton.alpha = 0
            } completion: { [weak self] (success) in
                guard let self = self else { return }
                self.removeButtons()
                self.viewModel.currentData = layerData
                self.createButtons()
                self.showAnimation(sender.center)
            }
        } else {
            ControlButton.shared.viewToExpand.collapse()
            sender.action?()
        }
    }

    @objc func handleBackTapped(_ sender: UIButton) {
        currentButtons?.forEach({ (button) in
            button.hideAnimation()
        })

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backButton.alpha = 0
        } completion: { [weak self] (success) in
            guard let self = self else { return }

            if let superLayerKey = self.viewModel.currentData?.superMenuLayer ,
               let layerData = self.viewModel.menuData?.layer[superLayerKey] {
                self.removeButtons()
                self.viewModel.currentData = layerData
                self.createButtons()
                self.showAnimation()
            }
        }
    }
}

extension CGPoint {

    static func pointOnCircle(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)

        return CGPoint(x: x, y: y)
    }
}
