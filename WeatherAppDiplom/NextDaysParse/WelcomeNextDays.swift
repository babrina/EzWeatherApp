//
//  WelcomeNextDays.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation

class WelcomeNextDays: Codable {
    let cod: String
    let message, cnt: Int
    let list: [ListNextDays]
    let city: CityNextDays

    init(cod: String, message: Int, cnt: Int, list: [ListNextDays], city: CityNextDays) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}
