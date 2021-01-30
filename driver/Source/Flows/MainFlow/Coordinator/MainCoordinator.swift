//
//  MainCoordinator.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

class MainCoordinator: BaseCoordinator, MainCoordinatorOutputProtocol {
    
    var finishFlow: (() -> Void)?
    private let router: Router
    private let factory: ModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router, factory: ModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
   }
    
    override func start() {
        showMain()
    }
    
    func showMain()  {
        var createMain = factory.createMain()
        createMain.onGetListFlow = {
            [unowned self] navController in
            if navController.viewControllers.isEmpty == true {              
                let createOrderList = self.coordinatorFactory.createOrderListMainCoordinator(navController: navController)
                self.addDependency(createOrderList)
                createOrderList.start()
            }
        }
        
        createMain.onGetListMapFlow = {
            [unowned self] navController in
            if navController.viewControllers.isEmpty == true {
                let createOrderListMap = self.coordinatorFactory.createOrderListMapMainCoordinator(navController: navController)
                self.addDependency(createOrderListMap)
                createOrderListMap.start()
            }
        }
        
        createMain.onProfilFlow = {
            [unowned self] navController in
            if navController.viewControllers.isEmpty == true {
                let createProfil = self.coordinatorFactory.createProfilMainCoordinator(navController: navController)
                print(CFGetRetainCount(createProfil))
                self.addDependency(createProfil)
                print(CFGetRetainCount(createProfil))
                createProfil.start()
            }
        }
        
        
        
        
        createMain.onFinish = {
            [weak self]  in
            self?.childCoordinators.removeAll()
            self?.finishFlow?()
        }
        
        router.setRootModule(createMain, hideBar: true)     
    }
    
    
    
    
    deinit {
        print("deinit MainCoordinator")
    }
}
