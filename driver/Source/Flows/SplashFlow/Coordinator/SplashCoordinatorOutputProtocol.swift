//
//  SplashCoordinatorOutputProtocol.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

protocol SplashCoordinatorOutputProtocol: class {
    var finishFlow: ((_ auth:Bool) -> Void)? { get set }
}
