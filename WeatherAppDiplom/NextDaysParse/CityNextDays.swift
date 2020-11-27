//
//  CityNextDays.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation

class CityNextDays: Codable {
    let id: Int
    let name: String
    let coord: CoordNextDays
    let country: String
    let population, timezone, sunrise, sunset: Int

    init(id: Int, name: String, coord: CoordNextDays, country: String, population: Int, timezone: Int, sunrise: Int, sunset: Int) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
