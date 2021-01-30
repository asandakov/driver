//
//  OrderDetailView.swift
//  driver
//
//  Created by Алексей on 23.01.2021.
//

import UIKit

class OrderDetailView: UIView {
    
      let homeScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
      }()
        
    
    let contentStackView: UIStackView = {
       let content = UIStackView ()
       content.axis = .vertical
       content.translatesAutoresizingMaskIntoConstraints = false
       return content
    }()

    let descTextView: UITextView = {
       let text = UITextView ()
       text.font = Fonts.Text.textSemiboldFont(size: 16.0)
       text.isEditable = false
       text.isScrollEnabled = false
       text.textColor = Colors.Param.title
       text.translatesAutoresizingMaskIntoConstraints = false
       return text
    }()
      
    let listTableView: UITableView = {
        let list = UITableView()
        list.register(OrderDetailTableViewCell.self, forCellReuseIdentifier: OrderDetailTableViewCell.reuseId)
        list.isScrollEnabled = false
        list.showsVerticalScrollIndicator = false
        list.showsHorizontalScrollIndicator = false
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
       
  
    private var heightOrderTable:NSLayoutConstraint?
      
    public func decorate() {
          
         backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               
         addSubview(homeScroll)
         contentStackView.addSubview(listTableView)
         contentStackView.addSubview(descTextView)
         homeScroll.addSubview(contentStackView)
           
         setConstraints()
      }
    
    
   
     public func setHeightOrder(height:CGFloat = 0) {
        heightOrderTable?.isActive = false
        heightOrderTable = listTableView.heightAnchor.constraint(equalToConstant: height)
        heightOrderTable?.isActive = true
      }
    
     
    
      private func setConstraints() {
       
        homeScroll.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        homeScroll.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        homeScroll.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        homeScroll.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
               
 
        contentStackView.topAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.topAnchor, constant: 0).isActive = true
        contentStackView.widthAnchor.constraint(equalTo: homeScroll.widthAnchor).isActive = true
        contentStackView.heightAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.heightAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: descTextView.bottomAnchor, constant: 10).isActive = true
      
        
        listTableView.topAnchor.constraint(equalTo: contentStackView.topAnchor, constant: 10).isActive = true
        listTableView.widthAnchor.constraint(equalTo:    contentStackView.widthAnchor).isActive = true

        descTextView.topAnchor.constraint(equalTo: listTableView.bottomAnchor, constant: 15).isActive = true
        descTextView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 15).isActive = true
        descTextView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -15).isActive = true
        
       // descTextView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
   }

}
