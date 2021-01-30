//
//  ProfilViewControllerProtocol.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

protocol ProfilViewControllerProtocol: BaseViewControllerProtocol {
    var onFinish: (() -> Void)? { get set }
    var viewModel: ProfilViewModelProtocol!  { get set }
}
