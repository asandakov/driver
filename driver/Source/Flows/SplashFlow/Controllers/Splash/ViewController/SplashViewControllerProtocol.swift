//
//  SplashViewControllerProtocol.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

protocol SplashViewControllerProtocol: BaseViewControllerProtocol {
    var onFinish: ((_ auth:Bool) -> Void)? { get set }
    var viewModel: SplashViewModelProtocol!  { get set }
}
