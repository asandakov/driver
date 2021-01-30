//
//  CoordinatorFactoryProtocol.swift
//  driver
//
//  Created by Алексей on 18.01.2021.
//

import Foundation
import UIKit

protocol CoordinatorFactoryProtocol: class {
    
    func createSplashCoordinator(router: Router) -> CoordinatorProtocol&SplashCoordinatorOutputProtocol
    
    func createSignInCoordinator(router: Router) -> CoordinatorProtocol&SignInCoordinatorOutputProtocol
    
    func createMainCoordinator(router: Router) -> CoordinatorProtocol&MainCoordinatorOutputProtocol
    
    func createOrderListMainCoordinator(navController: UINavigationController) -> CoordinatorProtocol
    
    func createOrderListMapMainCoordinator(navController: UINavigationController) -> CoordinatorProtocol
    
    func createOrderDetailCoordinator(router: Router, order:Order) -> CoordinatorProtocol&OrderDetailCoordinatorOutputProtocol
    
    func createProfilMainCoordinator(navController: UINavigationController) -> CoordinatorProtocol
    
  
}
