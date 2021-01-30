//
//  ViewData.swift
//  driver
//
//  Created by Алексей on 20.01.2021.
//

import Foundation

enum SplashData {
    case initial
    case startProgress
    case endProgress
    case errorNetwork(msg:String)
    case finish(auth:Bool)
}
