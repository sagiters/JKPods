//
//  FunctionItemRepositoryImpl.swift
//  JKPods_Example
//
//  Created by Lien-Tai Kuo on 2022/3/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import JKPods

enum MenuLayer: String {
    case firstLayer
    case secondLayer
    case monitor
}

class FunctionItemRepositoryImpl: FunctionItemRepository {

    func getFunctionItems() -> JKDebugMenu<MenuLayer> {
        return JKDebugMenu(layer: [
            .firstLayer: JKDebugMenuData(superMenuLayer: nil, data: [
                JKDebugFunctionItem(imageName: "icons8-console-50",
                             name: "Alert",
                             action: {
                             },
                             subLayerKey: nil),
                JKDebugFunctionItem(imageName: "",
                             name: "Toast",
                             action: {
                             },
                             subLayerKey: nil),
                JKDebugFunctionItem(imageName: "",
                             name: "Console",
                             action: {
                             },
                             subLayerKey: nil),
                JKDebugFunctionItem(imageName: "",
                             name: "Monitors",
                             action: nil,
                             subLayerKey: .monitor),
            ]),
            .secondLayer: JKDebugMenuData(superMenuLayer: .firstLayer, data: [
                JKDebugFunctionItem(imageName: "",
                             name: "Google",
                             action: {
                             },
                             subLayerKey: nil),
                JKDebugFunctionItem(imageName: "",
                             name: "T2-2",
                             action: {
                                print("T2-2")
                             },
                             subLayerKey: nil),
                JKDebugFunctionItem(imageName: "",
                             name: "T2-3",
                             action: {
                                print("T2-3")
                             },
                             subLayerKey: nil),
            ]),
            .monitor: JKDebugMenuData(superMenuLayer: .firstLayer, data: [
                JKDebugFunctionItem(imageName: "",
                             name: "data log",
                             action: {
                             },
                             subLayerKey: nil),
                JKDebugFunctionItem(imageName: "",
                             name: "memory",
                             action: {
                                print("memory")
                             },
                             subLayerKey: nil),
                JKDebugFunctionItem(imageName: "",
                             name: "network",
                             action: {
                                print("network")
                             },
                             subLayerKey: nil),
            ]),
        ])
    }

}
