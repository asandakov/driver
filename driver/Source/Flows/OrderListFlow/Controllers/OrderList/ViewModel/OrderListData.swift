//
//  OrderListData.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import Foundation

enum OrderListData {
    case initial
    case startProgress
    case endProgress
    case successOrder(orderData:OrderResponce)
    case failureOrder(msg:String)
    case successOrderAction(idOrder:String, msg:String)
    case failureOrderAction(msg:String)
    case finish
}
