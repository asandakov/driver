//
//  SplashView.swift
//  driver
//
//  Created by Алексей on 20.01.2021.
//

import UIKit

class SplashView: UIView {

    public var viewData: SplashData = .initial {
        didSet {
            reloadData()
        }
    }
    
    let logoImage: UIImageView = {
       let img = UIImageView(image:Images.Splash.logo)
       img.frame.size = CGSize(width: 150, height: 150)
       img.translatesAutoresizingMaskIntoConstraints = false
       return img
    }()
    
    let nameLabel: UILabel = {
       let name = UILabel()
       name.font = Fonts.Text.textSemiboldFont(size: 24.0)
       name.text = Localization.Splash.name
       name.numberOfLines = 1
       name.textColor = Colors.Splash.name
       name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
   

    public func decorate() {
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(logoImage)
        addSubview(nameLabel)
        addSubview(indicatorView)
       
        setConstraints()

    }
    
    
    private func setConstraints() {
       
        logoImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: logoImage.frame.size.width).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: logoImage.frame.size.height).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        
        
        
    }
    
    private func reloadData() {
        
       
        
    }
}
