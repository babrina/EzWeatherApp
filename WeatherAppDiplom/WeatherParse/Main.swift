//
//  Main.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation

class Main: Codable {
    let temp, feelsLike, tempMin, tempMax, pressure, humidity: Double
    

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }

    init(temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Double, humidity: Double) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
    }
}
