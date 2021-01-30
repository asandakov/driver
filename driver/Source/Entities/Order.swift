//
//  Order.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import Foundation


class Order:Codable {
    var id = ""
    var number = ""
    var fio = ""
    var phone = ""
    var price = ""
    var dateDelivery = ""
    var interval = ""
    var addres = ""
    var addresMap = ""
    var idStatus = ""
    var nameStatus = ""
    var description = ""
    
    enum CodingKeys:String, CodingKey {
        case id = "ID"
        case number = "NUMBER_ORDER"
        case fio = "FIO_ORDER"
        case phone = "PHONE_ORDER"
        case price = "PRICE"
        case dateDelivery = "DATE_DELIVERY"
        case interval = "INTERVAL_TIME"
        case addres = "ADDRES"
        case addresMap = "ADDRES_MAP"
        case idStatus = "STATUS_ID"
        case nameStatus = "STATUS_NAME"
        case description = "DESCRIPTION"
    }
    
        
    
    func getPoint() -> (Double,Double)? {
   
        if  self.addresMap == "" {
            return nil
        }
                 
        
        let arPoint = self.addresMap.split(separator: ",")
        if  arPoint.count != 2 {
            return nil
        }
              
        guard let lat = Double(arPoint[0]),
              let long = Double(arPoint[1])
        else {
            return nil
        }
        
        return (lat,long)
    }
    
}



class OrderResponce:Codable {
    var orders:[Order] = []
    var count:Int = 0
    var isPage:Bool = false
    var allPage:Int = 0
  //  var curPage:Int = 0
   
    
    enum CodingKeys:String, CodingKey {
        case orders = "LIST"
        case count = "COUNT"
        case allPage = "ALL_PAGE"
        case isPage = "FLAG_NAV"
      //  case curPage = "CURRENT_PAGE"
    }
}


class OrderAction:Codable {
    var idOrder = 0
    var message = ""
    
    enum CodingKeys:String, CodingKey {
        case message = "MESSAGE"
        case idOrder = "ID"
    }
}
