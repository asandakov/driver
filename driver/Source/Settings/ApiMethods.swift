//
//  ApiMethods.swift
//  Flowers
//
//  Created by Алексей on 12.01.2021.
//

import Foundation


enum ApiMethods: String {
             
    case userInfo = "/v1/user.getUser/"
    case userAuth = "/v1/user.getAuth/"
    case userLogout = "/v1/user.getLogout/"
    case userToken = "/v1/token.getGeneratorRefresh/"
    case orderList = "/v1/order.getList/"
    case orderAction = "/v1/order.action/"
}
