//
//  OrderMapViewModelProtocol.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

protocol OrderMapViewModelProtocol {
    var updateViewData: ((OrderMapData)->())? { get set }
}
