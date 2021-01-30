//
//  SignInModuleFactoryProtocol.swift
//  driver
//
//  Created by Алексей on 18.01.2021.
//

import Foundation

protocol SignInModuleFactoryProtocol: class {
    func createSignIn() -> AuthViewControllerProtocol
}
