//
//  ControlViewModel.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/1/19.
//

import Foundation
import UIKit

public class ControlViewModel<LayerType: Hashable> {

    private let getFunctionItemsUseCase: AnyGetFunctionItemsUseCaseBase<LayerType>

    var currentData: JKDebugMenuData<LayerType>?
    var menuData: JKDebugMenu<LayerType>?
    var buttonCount: Int {
        guard let items = currentData?.data else {
            return 0
        }
        return items.count
    }

    let initialLayer: LayerType

    public init(getFunctionItemsUseCase: AnyGetFunctionItemsUseCaseBase<LayerType>, initialLayer: LayerType) {
        self.getFunctionItemsUseCase = getFunctionItemsUseCase
        self.initialLayer = initialLayer
        load()
    }

    func load() {
        menuData = getFunctionItemsUseCase.execute()
    }

}
