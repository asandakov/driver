//
//  MainiewControllerProtocol.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation
import UIKit
protocol MainViewControllerProtocol: BaseViewControllerProtocol {
     var onGetListFlow: ((UINavigationController) -> ())? { get set }
     var onGetListMapFlow: ((UINavigationController) -> ())? { get set }
     var onProfilFlow: ((UINavigationController) -> ())? { get set }
     var onFinish: (() -> Void)? { get set }
}
