//
//  SignInCoordinator.swift
//  driver
//
//  Created by Алексей on 16.01.2021.
//

import Foundation

class SignInCoordinator: BaseCoordinator, SignInCoordinatorOutputProtocol {
    
    var finishFlow: (() -> Void)?
    
    private let router: Router
    private let factory: SignInModuleFactoryProtocol
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router, factory: SignInModuleFactoryProtocol, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
   }
    
    override func start() {
        showCreate()
    }
    
    private func showCreate() {
        var createSignIn = factory.createSignIn()

        createSignIn.viewModel = AuthViewModel(factoryNetwork:FactoryNetworkService(), factoryDb:FactoryDbStorageService())
        createSignIn.onFinish = { [weak self] in
            
            guard let self = self else {
                return
            }

            self.childCoordinators.removeAll()

            var coordinator = self.coordinatorFactory.createMainCoordinator(router:  self.router)
            
            coordinator.finishFlow = { [weak self, weak coordinator]  in
                guard let self = self else { return }
            
                self.removeDependency(coordinator)
            }
            
            self.addDependency(coordinator)
            coordinator.start()
            
             //self?.finishFlow?()
         }
          
        router.setRootModule(createSignIn, hideBar: true)
      
    }
    
    
  
    deinit {
        print("deinit SignInCoordinator")
    }
}
