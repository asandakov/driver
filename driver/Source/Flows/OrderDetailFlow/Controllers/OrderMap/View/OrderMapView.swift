//
//  OrderMapView.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import UIKit
import YandexMapsMobile

class OrderMapView: UIView {
    
    let mapView: YMKMapView = {
       let map = YMKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
       return map
    }()
    
      
    public func decorate() {
        
          addSubview(mapView)
          backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          setConstraints()        
    }
   
      
      private func setConstraints() {
  
        mapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        
        mapView.heightAnchor.constraint(equalToConstant: frame.size.height).isActive = true

      }

}
