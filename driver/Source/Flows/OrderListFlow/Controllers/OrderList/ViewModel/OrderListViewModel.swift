//
//  OrderListViewModel.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import Foundation


class OrderListViewModel: OrderListViewModelProtocol {
    
    let factoryNetwork:FactoryNetworkServiceProtocol
    let factoryDb:FactoryDbStorageServiceProtocol
    var isPageOrder = false
  
    
    public var updateViewData: ((OrderListData) -> ())? {       
        didSet{
                start()
        }
    }
    
    init(factoryNetwork:FactoryNetworkServiceProtocol, factoryDb:FactoryDbStorageServiceProtocol) {
        self.factoryNetwork = factoryNetwork
        self.factoryDb = factoryDb
        updateViewData = nil
    }
    
    private func start() { 
         updateViewData?(.initial)
    }
    
    
 
    
    func onLogout() -> () {
                  
        self.updateViewData?(.startProgress)
        let query = DispatchQueue.global(qos: .userInteractive)
        query.async {
            sleep(1)
            DispatchQueue.main.async {
                self.updateViewData?(.endProgress)
            }
        }
 
    }
    
    
    func onOrderList(type:TypeOrder = .all, page:Int = 1, isPage:Bool = false, filter:[String:String] = [:], search:String = "") -> () {
      
        if page == 1{
            self.updateViewData?(.startProgress)
        }
        
        self.isPageOrder = isPage
        
        var filter = filter
        switch type {
            case .all:
             break
            case .active:
                  filter["status"] = "2"
            case .noActive:
                  filter["status"] = "3"
        }
                
        let params = [
            "page": String(page),
            "filter": filter.queryString,
            "search": search
        ]
        
        factoryNetwork.getOrderNetworkService().getList(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
                
                   if params["page"] != "1" && !self.isPageOrder {
                        return
                   }
            
            
                    if page == 1 {
                        self.updateViewData?(.endProgress)
                    }
                   
                          
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
   
    
    
    
    func onOrderAction(idOrder:String) -> () {
      
        self.updateViewData?(.startProgress)
                
        let params = [
            "id": idOrder
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
