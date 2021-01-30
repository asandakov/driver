//
//  ApplicationCoordinator.swift
//  driver
//
//  Created by Алексей on 16.01.2021.
//

import Foundation
import UIKit

class ApplicationCoordinator: BaseCoordinator {
   
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    enum Action {
        case splash
        case auth
        case main
    }
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runAction(action: .splash)
    }
    
    
    private func runAction(action:Action) {
        switch action {
            case .splash:
                splashFlow()
            break
            case .auth:
                authFlow()
            break
            case .main:
                mainFlow()
            break
        }
    }
    
    private func splashFlow() {
        
        let coordinator = coordinatorFactory.createSplashCoordinator(router: router)
     
        coordinator.finishFlow = { [weak self, weak coordinator] auth in
            guard let self = self else { return }
            
            
            self.removeDependency(coordinator)
            
            if auth {
               self.runAction(action: .main)
            }
            else{
               self.runAction(action: .auth)
            }
            
         
        }
        addDependency(coordinator)
        coordinator.start()
   
    }
    
    private func authFlow() {
        
        let coordinator = coordinatorFactory.createSignInCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self else { return }
           
            self.removeDependency(coordinator)
            self.runAction(action: .main)
            
        }
        addDependency(coordinator)
        coordinator.start()
    }

    private func mainFlow() {
        var coordinator = coordinatorFactory.createMainCoordinator(router: router)
    
        coordinator.finishFlow = { [weak self, weak coordinator]  in
            guard let self = self else { return }
        
            self.removeDependency(coordinator)
        }
       
        
        addDependency(coordinator)
        coordinator.start()
    }
    
}
