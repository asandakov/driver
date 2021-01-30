//
//  SignInViewController.swift
//  driver
//
//  Created by Алексей on 16.01.2021.
//

import UIKit

class AuthViewController: BaseViewController, AuthViewControllerProtocol {

    var onFinish: (() -> Void)?
    
    private let rootView = AuthView()
    var viewModel: AuthViewModelProtocol!
    override func loadView() {
        super.loadView()
        self.replacementRootView(newView: rootView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.decorate()
        
        rootView.sendBotton.addTarget(self, action: #selector(sendLogon), for: .touchUpInside)
        
        updateView()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
       
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)       
    }
    
    
    @objc func sendLogon(){
        
        rootView.errorLabel.text = " "
        
        guard  let login = rootView.loginTextField.text,  let password =  rootView.passwordTextField.text else{
            return
        }
        
        if (login == "" || password == ""){
            rootView.errorLabel.text = Localization.Auth.Error.noEmptyField
            return
        }
        rootView.endEditing(true)
        viewModel.onLogon(login: login, password: password)
    }
    
   
    
    func updateView() {
        
        if viewModel == nil { assert(false, "no viewModel") }
        
        viewModel.updateViewData = { [weak self] viewData in
            
            switch viewData {
                case .startProgress:
                    self?.showProgressHUD()
                case .endProgress:
                    self?.hideProgressHUD()
                case .user(_):                   
                    self?.onFinish?()
               case let .errorNetwork(msg):
                   self?.rootView.errorLabel.text = msg
                default:
                break
            }     
          }
    }
    
    deinit {
        print("deinit AuthViewController")
    }
}
