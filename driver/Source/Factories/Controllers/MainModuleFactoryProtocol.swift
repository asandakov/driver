//
//  MainModuleFactoryProtocol.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

protocol MainModuleFactoryProtocol: class {
    func createMain() -> MainViewControllerProtocol
}
