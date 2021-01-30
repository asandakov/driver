//
//  Localization.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import Foundation

struct Localization {
    
    struct App {
        public static var name : String = "app.name".localized()
    }
    
    struct Error {
        public static var support : String = "error.support".localized()
    }
    
    struct Splash {
        public static var name : String = App.name
    }
    

    struct Auth {
        public static var name : String = "auth.name".localized()
        public static var login : String = "auth.login".localized()
        public static var password : String = "auth.password".localized()
        public static var send : String = "auth.send".localized()
        
        struct Error {
            public static var noAuth : String = "auth.error.no_auth".localized()
            public static var noEmptyField : String = "auth.error.empty_field".localized()   
        }
        
    }
    
    struct Network {
        public static var errorJson : String = "netrwork.error.json".localized()
    }
    
    struct Token {
        public static var error : String = "token.error".localized()
    }
  
    struct Profil {
        public static var title : String = "profil.title".localized()
        public static var titleTab : String = "profil.tab".localized()
        public static var fioParam : String = "profil.param.fio".localized()
        public static var fioNameParam : String = "profil.param.fio.name".localized()
        public static var dateParam : String = "profil.param.date".localized()
        public static var exit : String = "profil.exit".localized()
      
    }
    
    struct OrderList {
      
        public static var title : String = "order.title".localized()
        public static var titleTab : String = "order.tab".localized()
        public static var searchPlaceholder : String = "order.search.placeholder".localized()
        public static var typeActive : String = "order.type.active".localized()
        public static var typeNoActive : String = "order.type.active_no".localized()
        public static var actionOrder : String = "order.list.action".localized()
        
        public static var viewMap : String = "order.view.map".localized()
        public static var viewList : String = "order.view.list".localized()
       
    }
  
    struct OrderDetail {
        public static var title : String = "order.detail.title".localized()
        public static var titleSub : String = "order.detail.subtitle".localized()
        public static var back : String = "order.detail.back".localized()
        
        public static var paramId : String = "order.detail.param.id".localized()
        public static var paramNumber : String = "order.detail.param.number".localized()
        public static var paramFio : String = "order.detail.param.fio".localized()
        public static var paramPhone: String = "order.detail.param.phone".localized()
        public static var paramPrice : String = "order.detail.param.price".localized()
        public static var paramDate : String = "order.detail.param.dateDelivery".localized()
        public static var paramInterval : String = "order.detail.param.interval".localized()
        public static var paramAddres : String = "order.detail.param.addres".localized()
        public static var paramStatus : String = "order.detail.param.status".localized()
        public static var paramDescription : String = "order.detail.param.description".localized()
    }
    
    
    struct OrderDetailMap {
        public static var title : String = "order.detail.map.title".localized()
        public static var titleSub : String = "order.detail.map.subtitle".localized()
    }
   
    struct OrderListMap {
        public static var title : String = "order.map.title".localized()
        public static var titleTab : String = "order.map.tab".localized()
    }
    
    struct Alert {
        
        public static var okButton : String = "alert.ok.button".localized()
        public static var canselButton : String = "alert.cansel.button".localized()
        public static var tite : String = "alert.title".localized()
        
        struct Error {
            public static var tite : String = "alert.error.title".localized()
            public static var message : String = "alert.error.message".localized()
          
        }
        struct Profil {
            public static var okButton : String = "profil.alert.ok.button".localized()
            public static var title : String = "profil.alert.title".localized()
            public static var message : String = "profil.alert.message".localized()
        }
        
        struct Order {
            
            public static var okButton : String = "order.alert.action.ok.button".localized()
            public static var title : String = "order.alert.action.title".localized()
            public static var message : String = "order.alert.action.message".localized()
            
        }
      
        
    }
    
}


