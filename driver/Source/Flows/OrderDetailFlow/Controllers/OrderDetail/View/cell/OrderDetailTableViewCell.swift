//
//  OrderDetailTableViewCell.swift
//  driver
//
//  Created by Алексей on 24.01.2021.
//


import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    static let reuseId = "OrderDetailTableViewCell"
       
    let titleLabel: UILabel = {
       let title = UILabel()
       title.font = Fonts.Text.textSemiboldFont(size: 12.0)
       title.numberOfLines = 1
       title.textColor = Colors.Param.title
       title.translatesAutoresizingMaskIntoConstraints = false
       return title
    }()
    
    let nameLabel: UILabel = {
       let name = UILabel()
       name.font = Fonts.Text.textSemiboldFont(size: 16.0)
       name.numberOfLines = 2
       name.textColor = Colors.Param.name
       name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()

    
    
    var buyBottonAction : (() -> ())?
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
     
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        

        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
    
                                     
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
      
    
    
    func setConstraint() {

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true

        
    }

}
