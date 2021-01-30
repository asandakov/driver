//
//  RouterProtocol.swift
//  driver
//
//  Created by Алексей on 18.01.2021.
//

import Foundation
import UIKit

protocol RouterProtocol: Presentable {
    
      func present(_ module: Presentable?)
      func present(_ module: Presentable?, animated: Bool)
      
      func push(_ module: Presentable?)
      func push(_ module: Presentable?, hideBottomBar: Bool)
      func push(_ module: Presentable?, animated: Bool)
      func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
      func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
      
      func popModule()
      func popModule(animated: Bool)
      
      func dismissModule()
      func dismissModule(animated: Bool, completion: (() -> Void)?)
      
      func setRootModule(_ module: Presentable?)
      func setRootModule(_ module: Presentable?, hideBar: Bool)
      
      func popToRootModule(animated: Bool)
    
     func getRootControllerApp() -> UINavigationController?
    
}
