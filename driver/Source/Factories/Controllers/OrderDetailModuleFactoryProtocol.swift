//
//  OrderDetailModuleFactoryProtocol.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

protocol OrderDetailModuleFactoryProtocol: class {
    func createOrderDetail() -> OrderDetailViewControllerProtocol
    func createOrderMap() -> OrderMapViewControllerProtocol
}
