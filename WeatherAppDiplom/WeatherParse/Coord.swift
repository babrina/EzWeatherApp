//
//  Coord.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation
class Coord: Codable {
    let lon, lat: Double

    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}
