//
//  JKDebugFunctionItem.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/1/18.
//

import Foundation

public struct JKDebugMenu<T: Hashable> {
    let layer: [T: JKDebugMenuData<T>]
    public init(layer: [T: JKDebugMenuData<T>]) {
        self.layer = layer
    }
}

public struct JKDebugMenuData<T: Hashable> {
    let superMenuLayer: T?
    let data: [JKDebugFunctionItem<T>]
    public init(superMenuLayer: T?, data: [JKDebugFunctionItem<T>]) {
        self.superMenuLayer = superMenuLayer
        self.data = data
    }
}

public struct JKDebugFunctionItem<T: Hashable> {
    let imageName: String
    let name: String
    let action: (() -> Void)?
    let subLayerKey: T?
    public init(imageName: String, name: String, action: (() -> Void)?, subLayerKey: T?) {
        self.imageName = imageName
        self.name = name
        self.action = action
        self.subLayerKey = subLayerKey
    }
}
