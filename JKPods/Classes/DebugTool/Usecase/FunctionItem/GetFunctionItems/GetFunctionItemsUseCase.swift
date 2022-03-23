//
//  GetFunctionItemUseCase.swift
//  ShellApp
//
//  Created by Lien-Tai Kuo on 2021/1/19.
//

import Foundation

protocol GetFunctionItemsUseCaseInterface {

    associatedtype UseCaseType: Hashable

    func execute() -> JKDebugMenu<UseCaseType>
}

public class AnyGetFunctionItemsUseCaseBase<ConcreteType: Hashable>: GetFunctionItemsUseCaseInterface {
    func execute() -> JKDebugMenu<ConcreteType> {
        fatalError("Method has to be overriden this is an abstract class")
    }
}

public class GetFunctionItemsUseCase<ImplementingType: FunctionItemRepository>: AnyGetFunctionItemsUseCaseBase<ImplementingType.LayerType> {

    private let functionItemRepository: ImplementingType

    public init(functionItemRepository: ImplementingType) {
        self.functionItemRepository = functionItemRepository
    }

    override func execute() -> JKDebugMenu<ImplementingType.LayerType> {
        return functionItemRepository.getFunctionItems()
    }
}

//class GetFunctionItemsUseCase<T: FunctionItemRepository>: GetFunctionItemsUseCaseInterface {
//
//    private let functionItemRepository: T
//
//    init(functionItemRepository: T) {
//        self.functionItemRepository = functionItemRepository
//    }
//
//    func execute() -> JKDebugMenu<T.LayerType> {
//        return functionItemRepository.getFunctionItems()
//    }
//}
