//
//  OrderDetailViewModelProtocol.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

protocol OrderDetailViewModelProtocol {
    var updateViewData: ((OrderDetailData)->())? { get set }
    func onOrder() -> ()
    func onOrderAction() -> ()
}
