//
//  SplashViewModelProtocol.swift
//  driver
//
//  Created by Алексей on 20.01.2021.
//

import Foundation

protocol SplashViewModelProtocol {
   var updateViewData: ((SplashData)->())? { get set }
    func onLogon() -> ()
}
