//
//  OrderListMapView.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//

import Foundation

import UIKit
import YandexMapsMobile

class OrderListMapView: UIView {
    
      let homeScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
      }()
    
      let titleLabel: UILabel = {
         let title = UILabel()
         title.font = Fonts.Text.textSemiboldFont(size: 12.0)
         title.text = Localization.Profil.fioParam
         title.numberOfLines = 1
         title.textColor = Colors.Param.title
         title.translatesAutoresizingMaskIntoConstraints = false
         return title
      }()
   
    let mapView: YMKMapView = {
       let map = YMKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
       return map
    }()
    
    let mapView2: UIView = {
       let map = UIView()
        map.translatesAutoresizingMaskIntoConstraints = false
       return map
    }()
      
    public func decorate() {
          
          backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               
          addSubview(homeScroll)
    
          
          homeScroll.addSubview(mapView)
          mapView.addSubview(titleLabel)
        
          setConstraints()

      }
   
      
      private func setConstraints() {
      
      
        homeScroll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        homeScroll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        homeScroll.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        homeScroll.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
       
        homeScroll.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        //homeScroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: listTableView.bottomAnchor, constant: 0).isActive = true
      
        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo:    homeScroll.contentLayoutGuide.topAnchor, constant: 50).isActive = true
        
      
  
        mapView.topAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.topAnchor).isActive = true
        
        mapView.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        
        mapView.heightAnchor.constraint(equalToConstant: frame.size.height).isActive = true
      

      }

}
