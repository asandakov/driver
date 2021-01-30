//
//  ProfilData.swift
//  driver
//
//  Created by Алексей on 21.01.2021.
//

import Foundation

enum ProfilData {
    case initial(user:UserTable)
    case startProgress
    case endProgress
    case successRefresh(user:UserTable)
    case failureRefresh(msg:String)
    case successExit
    case failureExit(msg:String)
    case finish
}
