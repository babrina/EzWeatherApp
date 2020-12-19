//
//  Sys.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation
class Sys: Codable {
//    let type, id: Int
    let country: String
    let sunrise, sunset: Int

    init(country: String, sunrise: Int, sunset: Int) {
//        self.type = type
//        self.id = id
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
