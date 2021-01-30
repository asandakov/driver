//
//  OrderListMapViewModelProtocol.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//

import Foundation


protocol OrderListMapViewModelProtocol {
    var updateViewData: ((OrderListMapData)->())? { get set }
    func onOrderList(page:Int, isPage:Bool, filter:[String:String], search:String) -> ()
}
