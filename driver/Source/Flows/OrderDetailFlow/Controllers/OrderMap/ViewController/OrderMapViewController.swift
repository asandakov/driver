//
//  OrderMapViewController.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import Foundation
import YandexMapsMobile

class OrderMapViewController: BaseViewController, OrderMapViewControllerProtocol {

    var onFinish: ((Bool) -> Void)?
    private let rootView = OrderMapView()
    var viewModel: OrderMapViewModelProtocol!
    var order: Order = Order() {
        didSet {
            setCenterMap()
        }
    }
    private var navigationTitleView = NavigationTitleView()
    
    override func loadView() {
        super.loadView()
        self.replacementRootView(newView: rootView)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.decorate()
       
        self.navigationItem.titleView = navigationTitleView
        navigationTitleView.set(title: Localization.OrderDetailMap.title, subTitle: "")
        
        updateView()
  
    }
    
  
    func setCenterMap() {
                
        if order.id != "" {
            navigationTitleView.set(title: Localization.OrderDetailMap.title, subTitle: Localization.OrderDetailMap.titleSub.replacingOccurrences(of: "%s", with: order.id))            
        }
        
        
        
        guard let icon = Images.Map.icon else {
            return
        }
       
        var (lat,long) = (Settings.centerMap.lat, Settings.centerMap.long)
 
        
        if let (latt,longg) = order.getPoint() {
            (lat,long) = (latt,longg)
        }
        
        rootView.mapView.mapWindow.map.move(with: YMKCameraPosition(target: YMKPoint(latitude: lat, longitude:long), zoom: 18, azimuth: 0, tilt: 0))
        let mapObjects = rootView.mapView.mapWindow.map.mapObjects
        let placemark = mapObjects.addPlacemark(with:  YMKPoint(latitude: lat, longitude: long))

        placemark.setIconWith(icon)        
    }
    
    
    func updateView() {
        
        if viewModel == nil { assert(false, "no viewModel") }
        
        viewModel.updateViewData = { [weak self] viewData in
            
            guard let self = self else { return }
            
            switch viewData {
                case let .initial(order):
                  self.order = order                  
                    print(self.order.addresMap)
                case .finish:
                    self.onFinish?(false)
            }
          }
    }
    
    deinit {
        self.onFinish?(true)
        print("deinit OrderMapViewController")
    }

}
