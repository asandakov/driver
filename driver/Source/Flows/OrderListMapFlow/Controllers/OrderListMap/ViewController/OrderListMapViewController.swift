//
//  OrderListViewController.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//

import UIKit
import Foundation
import YandexMapsMobile

class OrderListMapViewController: BaseViewController, OrderListMapViewControllerProtocol {
       
    var onOrderDetail: ((Order) -> Void)?
    var onFinish: (() -> Void)?
    
    private let rootView = OrderListMapView()
    var viewModel: OrderListMapViewModelProtocol!
    var orderData = OrderResponce()
    var orders: [Order] = []
    var curPage:Int = 1
   
    override func loadView() {
        super.loadView()
        self.replacementRootView(newView: rootView)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.decorate()
        
        self.navigationItem.title = Localization.OrderListMap.title
        self.navigationItem.backButtonTitle = Localization.OrderListMap.titleTab
        
        rootView.homeScroll.refreshControl = UIRefreshControl()
        rootView.homeScroll.refreshControl?.addTarget(self, action: #selector(refreshHome(sendrer:)), for: .valueChanged)

      

        rootView.mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: YMKPoint(latitude: Settings.centerMap.lat, longitude: Settings.centerMap.long), zoom: 10, azimuth: 0, tilt: 0),
               animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 0),
                   cameraCallback: nil)
      
        rootView.mapView.mapWindow.map.mapObjects.addTapListener(with: self)
      
        updateView()     
    }
    
    
    
    @objc func refreshHome(sendrer:UIRefreshControl){
        viewModel.onOrderList(page: curPage, isPage:false, filter: [:], search: "")
        rootView.homeScroll.refreshControl?.endRefreshing()
    }
    
    
    func changeMap() {
        
        let mapObjects = rootView.mapView.mapWindow.map.mapObjects
        mapObjects.clear()
   
        guard let icon = Images.Map.icon else {
            return
        }
        
        for order in self.orders {
            guard let (lat,long) = order.getPoint() else {
                continue
            }
            
            let placemark = mapObjects.addPlacemark(with:  YMKPoint(latitude: lat, longitude: long))
            placemark.userData = order
            placemark.setIconWith(icon)
        }
       
        rootView.mapView.mapWindow.map.move(with: YMKCameraPosition(target: YMKPoint(latitude: Settings.centerMap.lat, longitude: Settings.centerMap.long), zoom: 10, azimuth: 0, tilt: 0))
    
    }
     
    
    func updateView() {
        
        if viewModel == nil { assert(false, "no viewModel") }
     
        viewModel.updateViewData = { [weak self] viewData in
            
            guard let self = self else { return }
         
            switch viewData {
                case .initial:
                    DispatchQueue.main.async {
                        self.viewModel.onOrderList(page: self.curPage, isPage:false, filter: [:], search: "")
                    }
                case .startProgress:
                    self.showProgressHUD()
                case .endProgress:
                    self.hideProgressHUD()
                case let .failureOrder(msg):
                    self.showAlert(message: msg)
                case let .successOrder(orderData):
                    self.orders = orderData.orders
                    self.orderData = orderData
                    self.changeMap()
                case .finish:
                    self.onFinish?()
              
            }
          }
    }
    
    deinit {
        
        print("deinit OrderListMapViewController")
    }

}



extension OrderListMapViewController: YMKMapObjectTapListener {
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let userPoint = mapObject as? YMKPlacemarkMapObject else {
            return true
        }
        
        guard let order = userPoint.userData as? Order else {
            return true
        }

        self.onOrderDetail?(order)
        
        return true
    }
}
