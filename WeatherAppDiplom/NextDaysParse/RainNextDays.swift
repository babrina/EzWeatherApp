//
//  RainNextDays.swift
//  WeatherAppDiplom
//
//  Created by Андрей Замиралов on 21.11.2020.
//

import Foundation

class RainNextDays: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }

    init(the3H: Double) {
        self.the3H = the3H
    }
}
