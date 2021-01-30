//
//  SplashCoordinator.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import Foundation

class SplashCoordinator: BaseCoordinator, SplashCoordinatorOutputProtocol {
    
    var finishFlow: ((_ auth:Bool) -> Void)?
    
    private let router: Router
    private let factory: SplashModuleFactoryProtocol
    
    init (router: Router, factory: SplashModuleFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showSplash()
    }
    
    private func showSplash() {

        var createSplash = factory.createSplash()
        createSplash.viewModel = SplashViewModel(factoryNetwork:FactoryNetworkService(), factoryDb:FactoryDbStorageService())
        createSplash.onFinish = { [weak self] auth in
                       
            self?.finishFlow?(auth)
         }

        router.setRootModule(createSplash, hideBar: true)
    }
    
    deinit {
        print("deinit SplashCoordinator")
    }
}
