//
//  MainCoordinatorOutputProtocol.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import Foundation

protocol MainCoordinatorOutputProtocol {
    var finishFlow: (() -> Void)? { get set }
}
