//
//  OrderDetailViewController.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import UIKit


fileprivate struct NameFieldOrder {
    
}

class OrderDetailViewController: BaseViewController, OrderDetailViewControllerProtocol {
       
    var onOrderMap: (() -> Void)?   
    var order:Order = Order(){
        didSet {
            updateData()
        }
    }
    var onFinish: ((Bool) -> Void)?
    private let rootView = OrderDetailView()
    var viewModel: OrderDetailViewModelProtocol!
    var orderData = OrderResponce()
    var orders: [Order] = []
    
    var dataOrder:[[String:String]] = [[:]]
    
    let heightOrderTable:CGFloat = 60
    
    
    override func loadView() {
        super.loadView()
        self.replacementRootView(newView: rootView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.decorate()
       
        self.navigationItem.title = Localization.OrderDetail.titleSub
        self.navigationItem.backButtonTitle = Localization.OrderDetail.back
        
        rootView.homeScroll.refreshControl = UIRefreshControl()
        rootView.homeScroll.refreshControl?.addTarget(self, action: #selector(refreshHome(sendrer:)), for: .valueChanged)
                  
        let actionOrderItem = UIBarButtonItem(image: Images.DetailMap.actionOrder, style: .plain, target: self, action: #selector(actionOrder))
      
        let mapItem = UIBarButtonItem(image: Images.DetailMap.map, style: .plain, target: self, action: #selector(openMap))
     
        self.navigationItem.rightBarButtonItems = [mapItem,actionOrderItem]
        
        rootView.listTableView.delegate = self
        rootView.listTableView.dataSource = self
  
        updateView()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
    }
    
    @objc func openMap(){
        self.onOrderMap?()
    }
    
    @objc func actionOrder(){
        
        let title = Localization.Alert.Order.title.replacingOccurrences(of: "%s", with: order.id)

        self.showAlert(tite: title, message: "",  okButton: Localization.Alert.Order.okButton, handlerOkButton: {()  in
                  
            self.viewModel.onOrderAction()

        },canselButton: Localization.Alert.canselButton)
      
   }
 
    
    
    @objc func refreshHome(sendrer:UIRefreshControl){
        viewModel.onOrder()
        rootView.homeScroll.refreshControl?.endRefreshing()
    }
    
    func updateData() {
        if order.id != "" {
            
            self.navigationItem.title = Localization.OrderDetail.title.replacingOccurrences(of: "%s", with: order.id)
            
            
            dataOrder = [
                ["param":Localization.OrderDetail.paramStatus,"value":order.nameStatus],
                ["param":Localization.OrderDetail.paramDate,"value":order.dateDelivery + " " + order.interval],
                ["param":Localization.OrderDetail.paramFio,"value":order.fio],
                ["param":Localization.OrderDetail.paramPhone,"value":order.phone.applyPatternOnNumbers()],
                ["param":Localization.OrderDetail.paramPrice,"value":order.price.stingWithCurrency],  ["param":Localization.OrderDetail.paramAddres,"value":order.addres]               
            ]
        }
        
        if order.idStatus != "2" {
            self.navigationItem.rightBarButtonItems?.last?.isEnabled = false
        }
        
        self.rootView.descTextView.text = order.description
        self.rootView.listTableView.reloadData()
        self.rootView.setHeightOrder(height:heightOrderTable*CGFloat(self.dataOrder.count))
    }
    
    func updateView() {
        
        if viewModel == nil { assert(false, "no viewModel") }
        
        viewModel.updateViewData = { [weak self] viewData in
            
            guard let self = self else { return }
            
            switch viewData {
               case let .initial(order):
                   self.order = order
                case .startProgress:
                    self.showProgressHUD()
                case .endProgress:
                    self.hideProgressHUD()
                case let .failureOrder(msg):
                    self.showAlert(message: msg)
                case let .successOrder(orderData):
                    self.orderData = orderData
                    if let firstOrder = self.orderData.orders.first{
                        self.order = firstOrder
                    }                   
                case .successOrderAction(_,_):
                    self.navigationItem.rightBarButtonItems?.last?.isEnabled = false
                    self.viewModel.onOrder()
                case let .failureOrderAction(msg):
                  self.showAlert(message: msg)
                case .finish:
                    self.onFinish?(false)
              
            }
          }
    }
    
    deinit {
        self.onFinish?(true)
        print("deinit OrderDetailViewController")
    }

}


extension  OrderDetailViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataOrder.count
    }
      
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailTableViewCell.reuseId, for: indexPath) as? OrderDetailTableViewCell else {
            return UITableViewCell()
        }
        
             
        cell.titleLabel.text = self.dataOrder[indexPath.row]["param"]
        cell.nameLabel.text = self.dataOrder[indexPath.row]["value"]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return heightOrderTable
    }
}
