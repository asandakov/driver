//
//  OrderMapViewControllerProtocol.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

protocol OrderMapViewControllerProtocol: BaseViewControllerProtocol {
    var onFinish: ((Bool) -> Void)? { get set }
    var viewModel: OrderMapViewModelProtocol!  { get set }
    
}
