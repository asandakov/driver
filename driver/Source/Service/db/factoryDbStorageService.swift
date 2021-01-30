//
//  factoryDBStorage.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

protocol FactoryDbStorageServiceProtocol {
    func getTokenDbStorageService() -> TokenDbStorageServiceProtocol
    func getUserDbStorageService() -> UserDbStorageServiceProtocol
}

class FactoryDbStorageService: FactoryDbStorageServiceProtocol {
    
    func getTokenDbStorageService() -> TokenDbStorageServiceProtocol{
        return TokenDbStorageService.defaultFactory
    }
    
    
    func getUserDbStorageService() -> UserDbStorageServiceProtocol{
        return UserDbStorageService.defaultFactory
    }
}
