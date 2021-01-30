//
//  OrderListCoordinator.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

class OrderListCoordinator: BaseCoordinator{
   
    private let router: Router
    private let factory: OrderListModuleFactoryProtocol
    private let coordinatorFactory: CoordinatorFactory
    
    init (router: Router, factory: OrderListModuleFactoryProtocol, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    
    override func start() {
        showOrderList()
    }
    
    
    func showOrderList() {
        var createOrderList = factory.createOrderList()
        createOrderList.viewModel = OrderListViewModel(factoryNetwork:FactoryNetworkService(), factoryDb:FactoryDbStorageService())
        
        
        createOrderList.onFinish = { [weak self] () in
            self?.finish()
        }
            
        createOrderList.onOrderDetail = { [weak self] (order) in
          
            self?.OrderDetailFlow(order:order)
        }
        
        router.setRootModule(createOrderList)
    }
    
    private func OrderDetailFlow(order:Order) {
        
        let coordinator = coordinatorFactory.createOrderDetailCoordinator(router: router, order:order)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self else { return }
           
            //self.router.popModule()
            self.removeDependency(coordinator)
            
        }
              
        addDependency(coordinator)
        coordinator.start()
    }
    
    func finish() {
        if  let coordinator = SceneDelegate.shared?.applicationCoordinator{
            coordinator.start()
        }
    }
    
    deinit {
        print("deinit OrderListCoordinator")
    }
}
