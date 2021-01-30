//
//  OrderMapCoordinator.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//

import Foundation


class OrderListMapCoordinator: BaseCoordinator{
   
    private let router: Router
    private let factory: OrderListMapModuleFactoryProtocol
    private let coordinatorFactory: CoordinatorFactory
    
    init (router: Router, factory: OrderListMapModuleFactoryProtocol, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    
    override func start() {
        showOrderListMap()
    }
    
    
    func showOrderListMap() {
        var createOrderListMap = factory.createOrderListMap()
        createOrderListMap.viewModel = OrderListMapViewModel(factoryNetwork:FactoryNetworkService(), factoryDb:FactoryDbStorageService())
        
        
        createOrderListMap.onFinish = { [weak self] () in
            self?.finish()
        }
            
        createOrderListMap.onOrderDetail = { [weak self] (order) in
          
            self?.OrderDetailFlow(order:order)
        }
        
        router.setRootModule(createOrderListMap)
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
        print("deinit OrderListMapCoordinator")
    }
}
