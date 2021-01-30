//
//  ProfilViewController.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import UIKit

class ProfilViewController: BaseViewController, ProfilViewControllerProtocol {

    var onFinish: (() -> Void)?
    
    private let rootView = ProfilView()
    
    var viewModel: ProfilViewModelProtocol!
    
    override func loadView() {
        super.loadView()
        self.replacementRootView(newView: rootView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.decorate()
     
        self.navigationItem.title = Localization.Profil.title
        
        rootView.homeScroll.refreshControl = UIRefreshControl()
        rootView.homeScroll.refreshControl?.addTarget(self, action: #selector(refreshHome(sendrer:)), for: .valueChanged)
        
                
        let exitItem = UIBarButtonItem(image: Images.Profil.exit, style: .plain, target: self, action: #selector(exitApp))
     
        self.navigationItem.rightBarButtonItems = [exitItem]
        
        
        updateView()
    }
     
    @objc func exitApp(){
       
        self.showAlert(tite: Localization.Alert.Profil.title, message: Localization.Alert.Profil.message,  okButton: Localization.Alert.Profil.okButton, handlerOkButton: { ()  in
            
            self.viewModel.onLogout()
            
        },canselButton: Localization.Alert.canselButton)
    }
    
    @objc func refreshHome(sendrer:UIRefreshControl){
        
        self.viewModel.onRefresh()
        rootView.homeScroll.refreshControl?.endRefreshing()
    }
   
    
    func updateView() {
        
        if viewModel == nil { assert(false, "no viewModel") }
        
        viewModel.updateViewData = { [weak self] viewData in
            
            switch viewData {
               case let .initial(user):
                   self?.rootView.nameLabel.text = user.fio
                case .startProgress:
                    self?.showProgressHUD()
                case .endProgress:
                    self?.hideProgressHUD()
                case .successExit:
                    self?.onFinish?()
                case let .failureExit(msg):
                    self?.showAlert(message: msg)
                case .finish:
                    self?.viewModel.onLogout()
               case let .failureRefresh(msg):
                     self?.showAlert(message: msg)
                case let .successRefresh(user):
                    self?.rootView.nameLabel.text = user.fio
//                default:
//
//                break
            }
          }
    }
    
    deinit {
        print("deinit ProfilViewController")
    }

}
