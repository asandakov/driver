//
//  ProfilViewModel.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

class ProfilViewModel: ProfilViewModelProtocol {
    
    let factoryNetwork:FactoryNetworkServiceProtocol
    let factoryDb:FactoryDbStorageServiceProtocol
    
    public var updateViewData: ((ProfilData) -> ())? {
        didSet {
            start()
        }
    }
    
    init(factoryNetwork:FactoryNetworkServiceProtocol, factoryDb:FactoryDbStorageServiceProtocol) {
        self.factoryNetwork = factoryNetwork
        self.factoryDb = factoryDb
    }
    
    private func start() {
               
        if let user =  self.factoryDb.getUserDbStorageService().user(){
            updateViewData?(.initial(user:user))
        }else{                    
            updateViewData?(.initial(user:UserTable()))
        }
    }
    
  
    
    private func remodeDb() {
        let _ =  self.factoryDb.getUserDbStorageService().removeAll()
        
        let _ = self.factoryDb.getTokenDbStorageService().removeAll()
    }
    
    func onLogout() -> () {
                    
      
        self.updateViewData?(.startProgress)
        
        factoryNetwork.getUserNetworkService().getLogout(params: [:]) { [weak self] result in
                                    
                   guard let self = self else { return }
             
                   self.updateViewData?(.endProgress)
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let logoutResponce = try? decoder.decode(LogoutResponce.self, from: jsonData)
                                    else {
                                    
                                    self.updateViewData?(.failureExit(msg:Localization.Network.errorJson))
                                      return
                                   }
                            
             
                        
                            
                            self.remodeDb()
                 
                            if logoutResponce.auth {
                                self.updateViewData?(.successExit)
                            }else{
                                self.updateViewData?(.successExit)
                            }
                 
                            
                          
                        case  .failure(let error):
                            
                            let (error,code)  = error.errorDescription
                            
                            if  let codeMsg  = code{
                                
                                let elementsCode = ["token_refresh"]
                                if elementsCode.contains(codeMsg) {
                                     self.remodeDb()
                                     self.updateViewData?(.successExit)
                                    return
                                }
                               
                            }
                            
                            if let errorMsg  = error{
                                self.updateViewData?(.failureExit(msg:errorMsg))
                            }
                            
                    }
                

            }
        
    }
    
   
    func onRefresh() -> () {
              
        
        self.updateViewData?(.startProgress)
        
        factoryNetwork.getUserNetworkService().getUser(params: [:]) { [weak self] result in
                                    
                   guard let self = self else { return }
             
                   self.updateViewData?(.endProgress)
          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let userResponce = try? decoder.decode(UserResponce.self, from: jsonData)
                                    else {
                                    self.updateViewData?(.failureRefresh(msg:Localization.Network.errorJson))
                                      return
                                   }
                          
                            let userDb = UserTable()
                            if let user = userResponce.user {
                                userDb.id = 1
                                userDb.fio = user.fio
                                userDb.login = user.login
                                let _ = self.factoryDb.getUserDbStorageService().update(user: userDb)
                            }
                            
                            
                           self.updateViewData?(.successRefresh(user: userDb))
                            
                          
                        case  .failure(let error):
                            let (error,code)  = error.errorDescription
                           
                            if  let codeMsg  = code{
                               
                                let elementsCode = ["token_access", "info_user_1"]
                                if elementsCode.contains(codeMsg) {
                                    
                                    self.updateViewData?(.finish)
                                 
                                    return
                                }
                               
                            }
                            
                            if let errorMsg  = error{
                                self.updateViewData?(.failureRefresh(msg:errorMsg))
                            }
                            
                    }
                

            }
        
    
        
          }
    
}
