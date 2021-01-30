//
//  SignInCoordinatorOutputProtocol.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

protocol SignInCoordinatorOutputProtocol: class {
    var finishFlow: (() -> Void)? { get set }
}
