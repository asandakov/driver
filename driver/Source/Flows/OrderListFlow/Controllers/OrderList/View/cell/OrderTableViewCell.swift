//
//  OrderTableViewCell.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    static let reuseId = "OrderTableViewCell"
    
    let numberLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 14.0)
        name.numberOfLines = 2
        name.textColor = Colors.Common.grayLightColor
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    let dateLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 14.0)
        name.numberOfLines = 2
        name.textColor = Colors.Common.grayLightColor
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
       
    let fioLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 14.0)
        name.numberOfLines = 2
        name.textColor = Colors.Common.grayColor
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    let phoneButton:UIButton = {
        let phone = UIButton(type: .system)
        phone.contentEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        phone.setTitleColor(Colors.Common.grayColor, for: .normal)
        phone.titleLabel?.font =  Fonts.Text.textSemiboldFont(size: 14.0)
        phone.translatesAutoresizingMaskIntoConstraints = false
        return phone
    }()
    
    let addresLabel:UILabel = {
       let price = UILabel()
        price.font = Fonts.Text.textSemiboldFont(size: 14.0)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textColor = Colors.Common.grayColor
        return price
    }()
    
    
    var phoneAction : (() -> ())?
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(numberLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(fioLabel)
        contentView.addSubview(phoneButton)
        contentView.addSubview(addresLabel)
        
        phoneButton.addTarget(self, action: #selector(actionPhoneOrder(_:)), for: .touchUpInside)
                                     
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
      
  
    @objc func actionPhoneOrder(_ sender:UIButton){
        phoneAction?()
    }
      
    
    func setConstraint() {

        numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: numberLabel.topAnchor).isActive = true
              
        fioLabel.leadingAnchor.constraint(equalTo: numberLabel.leadingAnchor).isActive = true
        fioLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10).isActive = true
     

        phoneButton.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor).isActive = true
        phoneButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
      
        addresLabel.leadingAnchor.constraint(equalTo: numberLabel.leadingAnchor).isActive = true
        addresLabel.topAnchor.constraint(equalTo: fioLabel.bottomAnchor, constant: 10).isActive = true
        
    }

}

