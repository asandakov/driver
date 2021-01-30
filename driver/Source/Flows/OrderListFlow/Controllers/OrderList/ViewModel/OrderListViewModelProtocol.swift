//
//  OrderListViewModelProtocol.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import Foundation

enum TypeOrder {
    case all
    case active
    case noActive
}

protocol OrderListViewModelProtocol {
    var updateViewData: ((OrderListData)->())? { get set }
    func onOrderList(type:TypeOrder, page:Int, isPage:Bool, filter:[String:String], search:String) -> ()
    func onOrderAction(idOrder:String) -> ()
}
