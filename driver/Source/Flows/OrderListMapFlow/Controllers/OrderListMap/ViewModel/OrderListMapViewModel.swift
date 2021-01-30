//
//  OrderListMapViewModel.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//

import Foundation


class OrderListMapViewModel: OrderListMapViewModelProtocol {
    
    let factoryNetwork:FactoryNetworkServiceProtocol
    let factoryDb:FactoryDbStorageServiceProtocol
    var isPageOrder = false
  
    
    public var updateViewData: ((OrderListMapData) -> ())? {
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
    
    
    
    
    func onOrderList(page:Int = 1, isPage:Bool = false, filter:[String:String] = [:], search:String = "") -> () {
      
        if page == 1{
            self.updateViewData?(.startProgress)
        }
        
        self.isPageOrder = isPage
        
        var filter = filter
        filter["status"] = "2"
                
        let params = [
            "page": String(page),
            "limit": "100",
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
    
    
    
    
}
