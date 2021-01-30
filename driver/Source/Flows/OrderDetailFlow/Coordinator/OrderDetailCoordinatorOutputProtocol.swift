//
//  OrderDetailCoordinatorOutputProtocol.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

protocol OrderDetailCoordinatorOutputProtocol: class {
    var finishFlow: (() -> Void)? { get set }
}
