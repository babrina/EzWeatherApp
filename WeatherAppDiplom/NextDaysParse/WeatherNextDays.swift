//
//  WeatherNextDays.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation

class WeatherNextDays: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription: String
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }

    init(id: Int, main: MainEnum, weatherDescription: String, icon: String) {
        self.id = id
        self.main = main
        self.weatherDescription = weatherDescription
        self.icon = icon
    }
}

//enum Icon: String, Codable {
//    case the04D = "04d"
//    case the04N = "04n"
//    case the10D = "10d"
//    case the10N = "10n"
//}

enum MainEnum: String, Codable {
    case clouds = "Clouds"
    case rain = "Rain"
    case clear = "Clear"
}

enum DescriptionNextDays: String, Codable {
    case brokenClouds = "broken clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case moderateRain = "moderate rain"
    case heavyIntensityRain = "heavy intensity rain"
    
    
}
