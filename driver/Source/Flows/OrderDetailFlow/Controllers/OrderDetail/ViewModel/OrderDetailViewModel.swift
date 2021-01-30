//
//  OrderDetailViewModel.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation


class OrderDetailViewModel: OrderDetailViewModelProtocol {
    
    private let factoryNetwork:FactoryNetworkServiceProtocol
    private let factoryDb:FactoryDbStorageServiceProtocol
    private var order:Order
    
    public var updateViewData: ((OrderDetailData) -> ())? {
        didSet {
            start()
        }
    }
    
    init(factoryNetwork:FactoryNetworkServiceProtocol, factoryDb:FactoryDbStorageServiceProtocol, order:Order) {
        self.factoryNetwork = factoryNetwork
        self.factoryDb = factoryDb
        self.order = order
    }
    
    private func start() {
        updateViewData?(.initial(order:order))
    }
    
    
     
    
    func onOrder() -> () {
              
        let params = [
            "filter": "id="+order.id
        ]
        
        self.updateViewData?(.startProgress)
        
        factoryNetwork.getOrderNetworkService().getList(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
                            
                   self.updateViewData?(.endProgress)
                   
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let orderResponce = try? decoder.decode(OrderResponce.self, from: jsonData)
                                    else {
                                    
                                    self.updateViewData?(.failureOrder(msg:Localization.Network.errorJson))
                                      return
                                   }
                                       
                           
                            self.updateViewData?(.successOrder(orderData:orderResponce))
                            
                          
                        case  .failure(let error):
                           
                            let (error,code) = error.errorDescription
                                                                  
                            
                            if  let codeMsg  = code{
                               
                                let elementsCode = ["token_access"]
                                if elementsCode.contains(codeMsg) {
                                    
                                    self.updateViewData?(.finish)
                                 
                                    return
                                }
                               
                            }
                            
                            if let errorMsg  = error{
                                self.updateViewData?(.failureOrder(msg:errorMsg))
                            }
                            
                           
                            
                    }
                

            }
        
    }
   
    
    
    func onOrderAction() -> () {
      
        self.updateViewData?(.startProgress)
                
        let params = [
            "id": order.id
        ]
        
        factoryNetwork.getOrderNetworkService().getAction(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
                
                   self.updateViewData?(.endProgress)
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let orderAction = try? decoder.decode(OrderAction.self, from: jsonData)
                                    else {
                                    
                                    self.updateViewData?(.failureOrderAction(msg:Localization.Network.errorJson))
                                      return
                                   }
                                       
                            if orderAction.idOrder > 0 {
                                
                                self.updateViewData?(.successOrderAction(idOrder:String(orderAction.idOrder), msg:orderAction.message))
                            }else{
                                self.updateViewData?(.failureOrderAction(msg:Localization.Error.support))
                            }
                          
                        case  .failure(let error):
                           
                            let (error,code) = error.errorDescription
                            
                                          
                            
                            if  let codeMsg  = code{
                               
                                let elementsCode = ["token_access"]
                                if elementsCode.contains(codeMsg) {
                                    
                                    self.updateViewData?(.finish)
                                 
                                    return
                                }
                               
                            }
                            
                            if let errorMsg  = error{
                                self.updateViewData?(.failureOrderAction(msg:errorMsg))
                            }
                            
                           
                            
                    }
                

            }
        
    }
    
}
