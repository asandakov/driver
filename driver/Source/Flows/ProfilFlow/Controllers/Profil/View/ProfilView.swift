//
//  ProfilView.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import UIKit

class ProfilView: UIView {
    
     let homeScroll = UIScrollView()
    
      let titleLabel: UILabel = {
         let title = UILabel()
         title.font = Fonts.Text.textSemiboldFont(size: 12.0)
         title.text = Localization.Profil.fioParam
         title.numberOfLines = 1
         title.textColor = Colors.Param.title
         title.translatesAutoresizingMaskIntoConstraints = false
         return title
      }()
      
      let nameLabel: UILabel = {
         let name = UILabel()
         name.font = Fonts.Text.textSemiboldFont(size: 16.0)
         name.numberOfLines = 1
         name.textColor = Colors.Param.name
         name.translatesAutoresizingMaskIntoConstraints = false
         return name
      }()
      
            
         
      public func decorate() {
          
          backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         
          homeScroll.isScrollEnabled = true
          homeScroll.showsVerticalScrollIndicator = true
          homeScroll.showsHorizontalScrollIndicator = false
      
        
          addSubview(homeScroll)
          homeScroll.addSubview(titleLabel)
          homeScroll.addSubview(nameLabel)
      
          setConstraints()

      }
   
      
      private func setConstraints() {
      
        homeScroll.translatesAutoresizingMaskIntoConstraints = false
        homeScroll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        homeScroll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        homeScroll.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        
        homeScroll.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        homeScroll.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        
        titleLabel.leadingAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.topAnchor, constant: 20).isActive = true
        
        
        nameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
         
   

      }

}
