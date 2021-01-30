//
//  OrderMapViewModel.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

class OrderMapViewModel: OrderMapViewModelProtocol {
    
    private var order:Order
    public var updateViewData: ((OrderMapData) -> ())? {
        didSet {
            start()
        }
    }
    
    init(order:Order) {
        self.order = order
    }
    
    private func start() {
        updateViewData?(.initial(order:order))
    }
    
    
       
    
}
