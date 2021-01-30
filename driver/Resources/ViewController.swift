//
//  ViewController.swift
//  driver
//
//  Created by Алексей on 16.01.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Common.grayColor
        var abc = RequestNetworkCore()
        abc.url = "11"
        self.title =  "11"
   
        // Do any additional setup after loading the view.
    }


}

