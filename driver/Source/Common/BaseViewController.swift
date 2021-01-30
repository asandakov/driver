//
//  BaseViewController.swift
//  driver
//
//  Created by Алексей on 16.01.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func replacementRootView(newView:UIView){     
        newView.frame = view.frame
        view = newView
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
           return .portrait
    }
    
   
}
