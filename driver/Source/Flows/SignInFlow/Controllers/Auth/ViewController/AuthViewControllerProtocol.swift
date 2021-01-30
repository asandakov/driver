//
//  SignInViewControllerProtocol.swift
//  driver
//
//  Created by Алексей on 18.01.2021.
//

import Foundation

protocol AuthViewControllerProtocol: BaseViewControllerProtocol {
    var onFinish: (() -> Void)? { get set }
    var viewModel: AuthViewModelProtocol!  { get set }
}
