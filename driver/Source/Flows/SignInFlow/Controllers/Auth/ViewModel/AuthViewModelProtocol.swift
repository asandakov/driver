//
//  AuthViewModelProtocol.swift
//  driver
//
//  Created by Алексей on 20.01.2021.
//

import Foundation

protocol AuthViewModelProtocol {
    var updateViewData: ((AuthData)->())? { get set }
    func onLogon(login:String, password:String) -> ()
}
