//
//  ModuleFactory.swift
//  driver
//
//  Created by Алексей on 18.01.2021.
//

import Foundation

class ModuleFactory:
    SplashModuleFactoryProtocol,
    SignInModuleFactoryProtocol,
    MainModuleFactoryProtocol,
    OrderListModuleFactoryProtocol,
    OrderDetailModuleFactoryProtocol,
    ProfilModuleFactoryProtocol,
    OrderListMapModuleFactoryProtocol{
    
    func createSplash() -> SplashViewControllerProtocol {       
        return SplashViewController()
    }
    
    func createSignIn() -> AuthViewControllerProtocol {
         return AuthViewController()
    }
    
    func createMain() -> MainViewControllerProtocol {
        return MainViewController()
    }
    
    
    func createOrderList() -> OrderListViewControllerProtocol {
        return OrderListViewController()
    }
    
    func createOrderListMap() -> OrderListMapViewControllerProtocol {
        return OrderListMapViewController()
    }
    
    func createOrderDetail() -> OrderDetailViewControllerProtocol {
        return OrderDetailViewController()
    }
    
    func createOrderMap() -> OrderMapViewControllerProtocol {
        return OrderMapViewController()
    }
    
    
    func createProfil() -> ProfilViewControllerProtocol {
        return ProfilViewController()
    }        
}
