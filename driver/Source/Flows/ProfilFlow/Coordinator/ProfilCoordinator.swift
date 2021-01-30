//
//  ProfilCoordinator.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

class ProfilCoordinator: BaseCoordinator{
   
    private let router: Router
    private let factory: ProfilModuleFactoryProtocol
    private let coordinatorFactory: CoordinatorFactory
    
    init (router: Router, factory: ProfilModuleFactoryProtocol, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    
    override func start() {
        showProfil()
    }
    
    func showProfil() {
        var createProfil = factory.createProfil()
        createProfil.viewModel = ProfilViewModel(factoryNetwork:FactoryNetworkService(), factoryDb:FactoryDbStorageService())
        
        createProfil.onFinish = { () in
            
            if  let coordinator = SceneDelegate.shared?.applicationCoordinator{
                coordinator.start()
            }
        }
        
        router.setRootModule(createProfil)
    }
    
  
    deinit {
        print("deinit ProfilCoordinator")
    }
}
