//
//  ProfilViewModelProtocol.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

protocol ProfilViewModelProtocol {
    var updateViewData: ((ProfilData)->())? { get set }
    func onLogout() -> ()
    func onRefresh() -> ()
}
