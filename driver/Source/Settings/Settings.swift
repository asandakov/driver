//
//  Settings.swift
//  Flowers
//
//
//  Created by Алексей on 29.12.2020.
//

import Foundation

struct Settings {
    
    static var apiURL = "https://alexsandakov.ru/driver/app"
    static var newsURL = "https://tsvet-ryad.ru/articles/"
    static var accessTokenApi = "78172"
    static var yandexApi = "a6ff3a4c-1ebd-49dc-a8a4-516a8416e586"
    static var centerMap = (lat:55.753995, long: 37.614069)
   
    static func getApiUrl() -> URL? {
        guard let url = URL(string: self.apiURL)  else {
            return  nil
        }
        return url
    }
    
}
