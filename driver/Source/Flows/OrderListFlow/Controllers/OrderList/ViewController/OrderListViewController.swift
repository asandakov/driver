//
//  OrderListViewController.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import UIKit

class OrderListViewController: BaseViewController, OrderListViewControllerProtocol {
       
    var onOrderDetail: ((Order) -> Void)?
    var onFinish: (() -> Void)?
    
    private let rootView = OrderListView()
    var viewModel: OrderListViewModelProtocol!
    var orderData = OrderResponce()
    var orders: [Order] = []
    var curPage:Int = 1
    var isPage:Bool = true
    var timerSearch:Timer?
    var typeOrder:TypeOrder = .active
    var textSearch = ""
    
    override func loadView() {
        super.loadView()
        self.replacementRootView(newView: rootView)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.decorate()
        
        self.navigationItem.title = Localization.OrderList.title
        self.navigationItem.backButtonTitle = Localization.OrderList.titleTab
        
        rootView.homeScroll.refreshControl = UIRefreshControl()   
        rootView.homeScroll.refreshControl?.addTarget(self, action: #selector(refreshHome(sendrer:)), for: .valueChanged)

        rootView.listTableView.delegate = self
        rootView.listTableView.dataSource = self
        
        rootView.searchBar.delegate = self
        
        rootView.viewSegmented.addTarget(self, action: #selector(actionTypeOrder), for: .valueChanged)
        
        
        
        updateView()
      
    }
    
    
    
    @objc func refreshHome(sendrer:UIRefreshControl){
        curPage = 1
        viewModel.onOrderList(type:typeOrder,page: curPage, isPage:false, filter: [:], search: textSearch)
        rootView.homeScroll.refreshControl?.endRefreshing()
    }
    
    
    
    @objc func actionTypeOrder(target:UISegmentedControl){
       
        if  target == rootView.viewSegmented {
          
            switch rootView.viewSegmented.selectedSegmentIndex {
                case 0:
                    typeOrder = .active
                case 1:
                    typeOrder = .noActive
                default:
                    typeOrder = .active
                break
            }
            
             curPage = 1
             viewModel.onOrderList(type:typeOrder,page: curPage, isPage:false, filter: [:], search: textSearch)
            
        }
    }
    
    func updateView() {
        
        if viewModel == nil { assert(false, "no viewModel") }
    
        viewModel.updateViewData = { [weak self] viewData in
            
            guard let self = self else { return }
       
            switch viewData {
                case .initial:
                    DispatchQueue.main.async {
                        self.curPage = 1
                        self.viewModel.onOrderList(type:self.typeOrder,page: self.curPage, isPage:false, filter: [:], search: self.textSearch)
                    }
                case .startProgress:
                    self.showProgressHUD()
                    self.rootView.searchBar.endEditing(true)
                case .endProgress:
                    self.hideProgressHUD()
                    self.rootView.searchBar.endEditing(false)
                    self.rootView.listTableView.tableFooterView = nil
                case let .failureOrder(msg):
                    self.isPage = true
                    self.showAlert(message: msg)
                case let .successOrder(orderData):
                    self.isPage = true
                    if self.curPage == 1 {
                        self.orders = orderData.orders
                    }else{
                        self.orders = self.orders + orderData.orders
                    }
                    self.orderData = orderData
                    self.rootView.listTableView.reloadData()                   
                 case .successOrderAction(_,_):
                    self.curPage = 1
                    self.viewModel.onOrderList(type:self.typeOrder,page: self.curPage, isPage:false, filter: [:], search: self.textSearch)
                 case let .failureOrderAction(msg):
                       self.showAlert(message: msg)
                case .finish:
                    self.onFinish?()
               
            }
          }
    }
    
    deinit {
        
        print("deinit OrderListViewController")
    }

}

extension  OrderListViewController:  UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
      
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.reuseId, for: indexPath) as? OrderTableViewCell else {
            return UITableViewCell()
        }
        
        cell.numberLabel.text = "№"+self.orders[indexPath.row].id
        cell.dateLabel.text = self.orders[indexPath.row].dateDelivery + " " + self.orders[indexPath.row].interval
        cell.fioLabel.text = self.orders[indexPath.row].fio
        cell.phoneButton.setTitle(self.orders[indexPath.row].phone.applyPatternOnNumbers(), for: .normal)
        cell.phoneAction = {  [weak self] in
            guard let self = self else { return }
            guard let number = URL(string: "tel://" + self.orders[indexPath.row].phone) else { return }
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
        
        cell.addresLabel.text = self.orders[indexPath.row].addres
        
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 95
    }
           
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        onOrderDetail?(self.orders[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
        {
                
        if typeOrder != .active {
            return nil
        }
        
        if !self.orders.indices.contains(indexPath.row) {
           return nil
        }
                      
        
        let order = self.orders[indexPath.row]
                
        let actionOrder = UIContextualAction(style: .destructive, title: Localization.OrderList.actionOrder) { (action, view, handler) in
                 
                                      
                let title = Localization.Alert.Order.title.replacingOccurrences(of: "%s", with: order.id)
              
                self.showAlert(tite: title, message: "",  okButton: Localization.Alert.Order.okButton, handlerOkButton: { ()  in
                                            
                    self.viewModel.onOrderAction(idOrder: order.id)
                 
                    
                },canselButton: Localization.Alert.canselButton)
                                
            }
              
          
        
        
       actionOrder.backgroundColor = Colors.Common.readColor
            
        let configuration = UISwipeActionsConfiguration(actions: [actionOrder])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
   }
    
    func createSpinerFooter() -> UIView{
        let view = UIView(frame: CGRect(x: 0, y: 0, width:rootView.frame.size.width, height: 50))
        let spiner = UIActivityIndicatorView()
        spiner.startAnimating()
        spiner.center = view.center
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(spiner)
        return view
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.size.height {
              
                if scrollView is UITableView {
                                    
                    if isPage {
                        if orderData.isPage{
                            isPage = false
                            curPage = curPage + 1
                            rootView.listTableView.tableFooterView = self.createSpinerFooter()
                            viewModel.onOrderList(type:typeOrder,page: curPage, isPage:true, filter: [:], search: textSearch)
                        }else{
                            rootView.listTableView.tableFooterView = nil
                        }
                        
                        
                    }
                    
                }
           
             }
     }
}


extension  OrderListViewController: UISearchBarDelegate {
       
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       // rootView.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //rootView.searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        changeeSearch(searchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            changeeSearch(searchText: searchText)
        }
    }
   
    func changeeSearch(searchText:String = "") {
        
        timerSearch?.invalidate()
        timerSearch = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.searchAction(timer:)), userInfo: ["search": searchText], repeats: false)
    }
    
    
    @objc func searchAction(timer: Timer) {
           if  let userInfo = timer.userInfo as? [String: String],
                let search = userInfo["search"] {
                curPage = 1
                textSearch = search
                viewModel.onOrderList(type:typeOrder,page: curPage, isPage:false, filter: [:], search: search)
               
            }
    }
    
    
}
