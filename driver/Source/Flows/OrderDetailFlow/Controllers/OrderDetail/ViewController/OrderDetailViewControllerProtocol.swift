//
//  OrderDetailViewControllerProtocol.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

protocol OrderDetailViewControllerProtocol: BaseViewControllerProtocol {
    var onFinish: ((Bool) -> Void)? { get set }
    var viewModel: OrderDetailViewModelProtocol!  { get set }
    var onOrderMap: (() -> Void)? { get set }
}
