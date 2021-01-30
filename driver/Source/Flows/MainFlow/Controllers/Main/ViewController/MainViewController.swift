//
//  MainViewController.swift
//  driver
//
//  Created by Алексей on 19.01.2021.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate, MainViewControllerProtocol {

    var onFinish: (() -> Void)?
    var onGetListMapFlow: ((UINavigationController) -> ())?
    var onGetListFlow: ((UINavigationController) -> ())?
    var onProfilFlow: ((UINavigationController) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        tabBar.tintColor = Colors.Common.readColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
           
            let item1 = UINavigationController()
            item1.navigationBar.tintColor = Colors.Common.readColor
            let icon1 = UITabBarItem(title: Localization.OrderList.titleTab, image: Images.TabBar.list, selectedImage: nil)
            item1.tabBarItem = icon1
        
        
        
            let item2 = UINavigationController()
            item2.navigationBar.tintColor = Colors.Common.readColor
            let icon2 = UITabBarItem(title: Localization.OrderListMap.titleTab, image: Images.TabBar.map, selectedImage: nil)
            item2.tabBarItem = icon2
        
           let item3 = UINavigationController()
           item3.navigationBar.tintColor = Colors.Common.readColor
           let icon3 = UITabBarItem(title: Localization.Profil.titleTab, image: Images.TabBar.profil, selectedImage: nil)
           item3.tabBarItem = icon3
        
        
        
           self.viewControllers =  [item1, item2, item3]
        
           onGetListFlow?(item1)
           onGetListMapFlow?(item2)
           onProfilFlow?(item3)
        }


    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
    
    deinit {
        onFinish?()
        print("deinit MainViewController")
    }

}
