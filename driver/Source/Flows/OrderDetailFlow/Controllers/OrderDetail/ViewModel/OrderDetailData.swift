//
//  OrderDetailData.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

enum OrderDetailData {
    case initial(order:Order)
    case startProgress
    case endProgress
    case successOrder(orderData:OrderResponce)
    case failureOrder(msg:String)
    case successOrderAction(idOrder:String, msg:String)
    case failureOrderAction(msg:String)
    case finish
}
