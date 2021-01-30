//
//  Splash.swift
//  driver
//
//  Created by Алексей on 20.01.2021.
//

import UIKit

class SplashViewModel: SplashViewModelProtocol{
   
    let factoryNetwork:FactoryNetworkServiceProtocol
    let factoryDb:FactoryDbStorageServiceProtocol
    
    public var updateViewData: ((SplashData) -> ())? {
        didSet {
            start()
        }
    }
    
    init(factoryNetwork:FactoryNetworkServiceProtocol, factoryDb:FactoryDbStorageServiceProtocol) {
        self.factoryNetwork = factoryNetwork
        self.factoryDb = factoryDb
    }
    
    private func start() {
        updateViewData?(.initial)
    }
    
    
    func onLogon() -> () {
              
        
        //self.updateViewData?(.startProgress)
        
        factoryNetwork.getUserNetworkService().getUser(params: [:]) { [weak self] result in
                                    
                   guard let self = self else { return }
             
                //   self.updateViewData?(.endProgress)
          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let _ = try? decoder.decode(UserResponce.self, from: jsonData)
                                    else {
                                    self.updateViewData?(.errorNetwork(msg:Localization.Network.errorJson))
                                      return
                                   }
                          
                        self.updateViewData?(.finish(auth: true))
                            
                          
                        case  .failure(let error):
                            let (error,code)  = error.errorDescription
                           
                            if  let codeMsg  = code{
                               
                                let elementsCode = ["token_access", "info_user_1"]
                                if elementsCode.contains(codeMsg) {
                                    
                                    self.getTokenUser()
                                    return
                                }
                               
                            }
                            
                            if let errorMsg  = error{
                                self.updateViewData?(.errorNetwork(msg:errorMsg))
                            }
                            
                    }
                

            }
        
    
        
          }
    
    
    func getTokenUser() -> () {
                
       // self.updateViewData?(.startProgress)
        
        factoryNetwork.getUserNetworkService().getToken(params: [:]) { [weak self] result in
                                    
                   guard let self = self else { return }
             
               //    self.updateViewData?(.endProgress)
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let token = try? decoder.decode(Token.self, from: jsonData)
                                    else {
                                    
                                    self.updateViewData?(.errorNetwork(msg:Localization.Network.errorJson))
                                      return
                                   }
                            
                                                   
                        
                                let tokenDb = TokenTable()
                                tokenDb.id = 1
                                tokenDb.access = token.access
                                tokenDb.refresh = token.refresh
                                tokenDb.timeAssess = token.timeAssess
                            
                                if token.access != "" {
                                    let _ = self.factoryDb.getTokenDbStorageService().update(token: tokenDb)
                                    
                                    self.updateViewData?(.finish(auth: true))
                                                       
                                    return
                                }
                            
                           
                       
                            
                            self.updateViewData?(.finish(auth: false))
                            
                          
                        case  .failure(let error):
                           
                            let (_,_)  = error.errorDescription
                            self.updateViewData?(.finish(auth: false))
                         
                            
                            
                            
                    }
                

            }
        
        
    }
}
