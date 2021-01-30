//
//  AuthData.swift
//  driver
//
//  Created by Алексей on 20.01.2021.
//

import Foundation

enum AuthData {
    case initial
    case startProgress
    case endProgress
    case errorNetwork(msg:String)
    case user(user:User?)
}
