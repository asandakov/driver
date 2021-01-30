//
//  Images.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import UIKit

struct Images {

    struct App {
        static let logo = UIImage(named: "logo")
    }
    
    struct Splash {
        static let logo = App.logo
    }
    
    struct Photo {
        static let placeholder = UIImage(named: "placeholder")         
    }
    
    struct DetailMap {
        static let actionOrder = UIImage(named: "editUserIcon")
        static let map = UIImage(named: "NavBarMapIcon")
    }
    
    struct Profil {
        static let exit = UIImage(named: "logoutIcon")
    }
    
    struct Map {
        static let icon = UIImage(named: "iconMap")
    }
    
    struct TabBar {
        static let list = UIImage(named: "NavBarListIcon")
        static let map = UIImage(named: "NavBarMapIcon")
        static let profil = UIImage(named: "NavBarProfileIcon")
    }
}
