//
//  OrderDetailCoordinator.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation

class OrderDetailCoordinator: BaseCoordinator, OrderDetailCoordinatorOutputProtocol{
   
    var finishFlow: (() -> Void)?
    
    private let order: Order
    private let router: Router
    private let factory: OrderDetailModuleFactoryProtocol
    
    init (router: Router, factory: OrderDetailModuleFactoryProtocol, order:Order) {
        self.router = router
        self.factory = factory
        self.order = order
    }
    
    
    override func start() {
        showOrderDetail()
    }
    
    
    func showOrderDetail() {
        var createOrderDetail = factory.createOrderDetail()
        createOrderDetail.viewModel = OrderDetailViewModel(factoryNetwork:FactoryNetworkService(), factoryDb:FactoryDbStorageService(), order: self.order)
       
        createOrderDetail.onFinish = { [weak self] (auth) in
            
            if auth {
                self?.finishFlow?()
                
            }else{
                self?.finishApp()
            }
            
           
        }
        
        createOrderDetail.onOrderMap = { [weak self] in
            self?.showOrderMap()
        }
               
        router.push(createOrderDetail, hideBottomBar: true)  
    }
    
    func showOrderMap() {
        var createOrderMap = factory.createOrderMap()
        createOrderMap.viewModel = OrderMapViewModel(order: self.order)
       
        createOrderMap.onFinish = { [weak self] (auth) in
            
            if auth {
                
            }else{
                self?.finishApp()
            }
        }
        router.push(createOrderMap, hideBottomBar: true)
    }
    
    func finishApp() {
        if  let coordinator = SceneDelegate.shared?.applicationCoordinator{
            coordinator.start()
        }
    }
    
    deinit {
        print("deinit OrderDetailCoordinator")
    }
}
