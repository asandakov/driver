//
//  OrderNetworkService.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import Foundation


protocol OrderNetworkServiceProtocol {
    func getList(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    func getAction(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
   
}


class OrderNetworkService: OrderNetworkServiceProtocol {
    
    static public let defaultFactory = OrderNetworkService()
      
    func getList(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
           
        var tokenAccess = ""
        if let tokenInfo = TokenDbStorageService.defaultFactory.token() {
            tokenAccess = tokenInfo.access
        }
     
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "token" : tokenAccess
        ]
        
      
       
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
//        if (newParamsRequest["filter"]?.isEmpty) != nil {
//
//            if var filter = params["filter"] {
//                if filter == "" {
//                    filter = "status=2"
//                }else{
//                    filter = filter + "&status=2"
//                }
//
//                newParamsRequest["filter"] = filter
//            }
//
//        }
        
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.orderList.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            
            if (params["page"] != "1"){
                sleep(1)
            }
            
           // sleep(1)
            DispatchQueue.main.async {
               completion(result)
            }
         }
    
    
    }
    
  
    
    func getAction(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
           
        var tokenAccess = ""
        if let tokenInfo = TokenDbStorageService.defaultFactory.token() {
            tokenAccess = tokenInfo.access
        }
     
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi,
            "action" : "delivered",
            "token" : tokenAccess
        ]
       
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.orderAction.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
           // sleep(1)
            DispatchQueue.main.async {
               completion(result)
            }
         }
    
    
    }
    
}
