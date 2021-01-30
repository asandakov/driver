//
//  AuthViewModel.swift
//  driver
//
//  Created by Алексей on 20.01.2021.
//

import Foundation

class AuthViewModel: AuthViewModelProtocol {
    
    let factoryNetwork:FactoryNetworkServiceProtocol
    let factoryDb:FactoryDbStorageServiceProtocol
    
    public var updateViewData: ((AuthData) -> ())? {
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
    
    
    func onLogon(login:String, password:String) -> () {
                     
        let params = [
            "login": login.lowercased(),
            "password": password.lowercased()
        ]
        
        self.updateViewData?(.startProgress)
        
        factoryNetwork.getUserNetworkService().getAuth(params: params) { [weak self] result in
                                    
                   guard let self = self else { return }
             
                   self.updateViewData?(.endProgress)
                          
                    switch result {
                                   
                        case  .success(let data):
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let logonResponce = try? decoder.decode(LogonResponce.self, from: jsonData)
                                    else {
                                    
                                    self.updateViewData?(.errorNetwork(msg:Localization.Network.errorJson))
                                      return
                                   }
                            
                 
                            if let token = logonResponce.token {
                               
                                let tokenDb = TokenTable()
                                tokenDb.id = 1
                                tokenDb.access = token.access
                                tokenDb.refresh = token.refresh
                                tokenDb.timeAssess = token.timeAssess
                                
                                let _ = self.factoryDb.getTokenDbStorageService().update(token: tokenDb)
                            }
                            
                            if let user = logonResponce.user {
                                
                                let userDb = UserTable()
                                userDb.id = 1
                                userDb.fio = user.fio
                                userDb.login = user.login
                                let _ = self.factoryDb.getUserDbStorageService().update(user: userDb)
                            }
                                                        
                            
                            self.updateViewData?(.user(user:logonResponce.user))
                            
                          
                        case  .failure(let error):
                            
                            
                            let (error,_)  = error.errorDescription           
                            
                            if let errorMsg = error{
                                
                                self.updateViewData?(.errorNetwork(msg:errorMsg))
                            
                            }
                            
                    }
                

            }
        
    }
    
    
}
