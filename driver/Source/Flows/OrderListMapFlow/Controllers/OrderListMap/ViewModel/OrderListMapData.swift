//
//  OrderListMapData.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//

import Foundation

enum OrderListMapData {
    case initial
    case startProgress
    case endProgress
    case successOrder(orderData:OrderResponce)
    case failureOrder(msg:String)
    case finish
}
