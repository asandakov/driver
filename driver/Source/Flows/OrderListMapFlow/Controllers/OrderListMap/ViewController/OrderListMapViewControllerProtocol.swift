//
//  OrderListMapViewControllerProtocol.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//

import Foundation

protocol OrderListMapViewControllerProtocol: BaseViewControllerProtocol {
    var onFinish: (() -> Void)? { get set }
    var viewModel: OrderListMapViewModelProtocol!  { get set }
    var onOrderDetail: ((Order) -> Void)? { get set }
}
