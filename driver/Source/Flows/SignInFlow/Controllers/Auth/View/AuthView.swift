//
//  AuthView.swift
//  driver
//
//  Created by Алексей on 20.01.2021.
//

import UIKit

class AuthView: UIView, UITextFieldDelegate {

  
        
    let nameLabel: UILabel = {
       let name = UILabel()
       name.font = Fonts.Text.textSemiboldFont(size: 20.0)
       name.text = Localization.Auth.name
       name.numberOfLines = 1
       name.textColor = Colors.Common.grayColor
       name.translatesAutoresizingMaskIntoConstraints = false
       return name
    }()
    
    
    let errorLabel: UILabel = {
       let error = UILabel()
        error.font = Fonts.Text.textSemiboldFont(size: 12.0)
        error.text = " "
        error.numberOfLines = 0
        error.textColor = Colors.Common.readColor
        error.translatesAutoresizingMaskIntoConstraints = false
       return error
    }()
    
  
    let loginTextField: UITextField = {
       let login = UITextField()
       login.frame.size = CGSize(width: 200, height: 40)
       login.borderStyle = .roundedRect
       login.placeholder = Localization.Auth.login
       login.translatesAutoresizingMaskIntoConstraints = false
       return login
    }()
    
    let passwordTextField: UITextField = {
       let password = UITextField()
       password.frame.size = CGSize(width: 200, height: 40)
       password.borderStyle = .roundedRect
       password.placeholder = Localization.Auth.password
       password.isSecureTextEntry = true
       password.translatesAutoresizingMaskIntoConstraints = false
       return password
    }()
    
    let sendBotton:UIButton = {
        let send = UIButton(type: .system)
        send.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        send.setTitleColor(Colors.Button.text, for: .normal)
        send.setTitle(Localization.Auth.send, for: .normal)
        send.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 16.0)
        send.backgroundColor = Colors.Button.background
        send.layer.cornerRadius = 5
        send.translatesAutoresizingMaskIntoConstraints = false
        return send
    }()
    
    public func decorate() {
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(nameLabel)
        addSubview(errorLabel)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(sendBotton)       
        loginTextField.delegate = self
        passwordTextField.delegate = self
        setConstraints()

    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setConstraints() {

        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true

        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        
        loginTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginTextField.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 15).isActive = true
        loginTextField.widthAnchor.constraint(equalToConstant: loginTextField.frame.width).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: loginTextField.frame.height).isActive = true
        
        passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: passwordTextField.frame.width).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: passwordTextField.frame.height).isActive = true
        
        
        sendBotton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sendBotton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        sendBotton.widthAnchor.constraint(equalToConstant: sendBotton.frame.width).isActive = true
        sendBotton.heightAnchor.constraint(equalToConstant: sendBotton.frame.height).isActive = true

    }

}
