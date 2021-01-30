//
//  SplashViewController.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import UIKit

class SplashViewController: BaseViewController, SplashViewControllerProtocol {
   
      
    var onFinish: ((_ auth:Bool) -> Void)?
    
    private let rootView = SplashView()
    var viewModel: SplashViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.replacementRootView(newView: rootView)
        rootView.decorate()
        
        updateView()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        viewModel.onLogon()
    }

    func updateView() {
        
        if viewModel == nil { assert(false, "no viewModel") }
        
        viewModel.updateViewData = { [weak self] viewData in
            
            switch viewData {
                case .startProgress:
                    self?.showProgressHUD()
                case .endProgress:
                    self?.hideProgressHUD()
                case let .finish(auth):
                    self?.onFinish?(auth)
               case let .errorNetwork(msg):
                    self?.showAlert(message: msg)
               default:
                    self?.rootView.viewData = viewData
               break
            }
            
          
        }
     
    }

    deinit {
        print("deinit SplashViewController")
    }
}
