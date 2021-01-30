//
//  UserTable.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import Foundation

import RealmSwift
 
class UserTable: Object {
    @objc dynamic var id = 0
    @objc dynamic var fio = Localization.Profil.fioNameParam
    @objc dynamic var login = ""
    @objc dynamic var currentDate = Date()
    
  override static func primaryKey() -> String? {
           return "id"
  }
}
