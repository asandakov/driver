//
//  OrderListView.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import UIKit

class OrderListView: UIView {
    
      let homeScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
      }()
    
     
      let searchBar: UISearchBar = {
          let search = UISearchBar()
        
          search.placeholder = Localization.OrderList.searchPlaceholder
          search.translatesAutoresizingMaskIntoConstraints = false
          return search
      }()
            
    
    let viewSegmented: UISegmentedControl = {
        let segmented = UISegmentedControl(items: [Localization.OrderList.typeActive, Localization.OrderList.typeNoActive])
        segmented.frame.size = CGSize(width: 100, height: 40)
        segmented.selectedSegmentIndex = 0
        segmented.selectedSegmentTintColor = Colors.Common.readColor
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.Common.whiteColor], for: .selected)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    let listTableView: UITableView = {
        let list = UITableView()
        list.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.reuseId)
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
      
    public func decorate() {
          
          backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               
          addSubview(homeScroll)
          homeScroll.addSubview(searchBar)
          homeScroll.addSubview(viewSegmented)
          homeScroll.addSubview(listTableView)
 
      
          setConstraints()

      }
   
      
      private func setConstraints() {
      
      
        homeScroll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        homeScroll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        homeScroll.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        homeScroll.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
       
        homeScroll.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        //homeScroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: listTableView.bottomAnchor, constant: 0).isActive = true
      
        
        
        searchBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.topAnchor, constant: 20).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: frame.size.width - 20).isActive = true
    
        viewSegmented.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewSegmented.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        viewSegmented.widthAnchor.constraint(equalToConstant: frame.size.width - 20).isActive = true
        viewSegmented.heightAnchor.constraint(equalToConstant: viewSegmented.frame.size.height).isActive = true
                             
     
        listTableView.topAnchor.constraint(equalTo: viewSegmented.bottomAnchor, constant: 10).isActive = true
        listTableView.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true

        listTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
       

      }

}
