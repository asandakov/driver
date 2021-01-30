//
//  CoordinatorFactory.swift
//  driver
//
//  Created by Алексей on 18.01.2021.
//

import Foundation
import UIKit

class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func createSplashCoordinator(router: Router) -> CoordinatorProtocol&SplashCoordinatorOutputProtocol {
        
        return SplashCoordinator(router: router, factory: ModuleFactory())
    }
        
    func createSignInCoordinator(router: Router) -> CoordinatorProtocol&SignInCoordinatorOutputProtocol {
        return SignInCoordinator(router: router, factory: ModuleFactory(), coordinatorFactory: CoordinatorFactory())
    }
        
    func createMainCoordinator(router: Router) -> CoordinatorProtocol&MainCoordinatorOutputProtocol {
        return MainCoordinator(router: router, factory: ModuleFactory(), coordinatorFactory: CoordinatorFactory())
    }
    
    func createOrderListMainCoordinator(navController: UINavigationController) -> CoordinatorProtocol{
        return OrderListCoordinator(router: Router(rootController: navController), factory: ModuleFactory(),coordinatorFactory: CoordinatorFactory())
    }
    
    func createOrderListMapMainCoordinator(navController: UINavigationController) -> CoordinatorProtocol{
        return OrderListMapCoordinator(router: Router(rootController: navController), factory: ModuleFactory(),coordinatorFactory: CoordinatorFactory())
    }
    
    func createOrderDetailCoordinator(router: Router, order:Order) -> CoordinatorProtocol&OrderDetailCoordinatorOutputProtocol {
        return OrderDetailCoordinator(router: router, factory: ModuleFactory(), order:order)
    }
    
    func createProfilMainCoordinator(navController: UINavigationController) -> CoordinatorProtocol{       
       return ProfilCoordinator(router: Router(rootController: navController), factory: ModuleFactory(),coordinatorFactory: CoordinatorFactory())
    }
}
