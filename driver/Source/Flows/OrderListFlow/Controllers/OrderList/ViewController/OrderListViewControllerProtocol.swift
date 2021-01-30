//
//  OrderListViewControllerProtocol.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation



protocol OrderListViewControllerProtocol: BaseViewControllerProtocol {
    var onFinish: (() -> Void)? { get set }
    var viewModel: OrderListViewModelProtocol!  { get set }
    var onOrderDetail: ((Order) -> Void)? { get set }
}
