//
//  ListNextDays.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation

class ListNextDays: Codable {
    let dt: Int
    let main: MainClassNextDays
    let weather: [WeatherNextDays]
    let clouds: CloudsNextDays
    let wind: WindNextDays
    let visibility: Int
    let pop: Double
    let sys: SysNextDays
    let dtTxt: String
    let rain: RainNextDays?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }

    init(dt: Int, main: MainClassNextDays, weather: [WeatherNextDays], clouds: CloudsNextDays, wind: WindNextDays, visibility: Int, pop: Double, sys: SysNextDays, dtTxt: String, rain: RainNextDays?) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.visibility = visibility
        self.pop = pop
        self.sys = sys
        self.dtTxt = dtTxt
        self.rain = rain
    }
}
