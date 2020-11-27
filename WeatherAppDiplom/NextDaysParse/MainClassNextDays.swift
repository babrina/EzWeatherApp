//
//  MainClassNextDays.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation
class MainClassNextDays: Codable {
    let temp, feelsLike, tempMin, tempMax, pressure, seaLevel, grndLevel, humidity, tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }

    init(temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Double, seaLevel: Double, grndLevel: Double, humidity: Double, tempKf: Double) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
        self.humidity = humidity
        self.tempKf = tempKf
    }
}
