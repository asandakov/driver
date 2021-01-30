//
//  factoryNetworkService.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

protocol FactoryNetworkServiceProtocol {
    func getUserNetworkService() -> UserNetworkServiceProtocol
    func getOrderNetworkService() -> OrderNetworkServiceProtocol
}

class FactoryNetworkService: FactoryNetworkServiceProtocol {
    
    func getUserNetworkService() -> UserNetworkServiceProtocol{
        return UserNetworkService.defaultFactory
    }
    
    func getOrderNetworkService() -> OrderNetworkServiceProtocol{
        return OrderNetworkService.defaultFactory
    }
}
