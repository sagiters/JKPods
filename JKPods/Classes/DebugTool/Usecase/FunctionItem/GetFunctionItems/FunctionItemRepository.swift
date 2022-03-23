//
//  FunctionItemRepository.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/1/19.
//

import Foundation

public protocol FunctionItemRepository {

    associatedtype LayerType: Hashable

    func getFunctionItems() -> JKDebugMenu<LayerType>

}
