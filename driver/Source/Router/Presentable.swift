//
//  Presentable.swift
//  driver
//
//  Created by Алексей on 18.01.2021.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  
  func toPresent() -> UIViewController? {
    return self
  }
}
