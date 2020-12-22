import Foundation

struct ParseCurrentDay: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

//enum MainEnum: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case rain = "Rain"
//    case thunderstorm = "Thunderstorm"
//    case drizzle = "Drizzle"
//    case snow = "Snow"
//    case mist = "Mist"
//    case smoke = "Smoke"
//    case haze = "Haze"
//    case dust = "Dust"
//    case fog = "Fog"
//    case sand = "Sand"
//    case ash = "Ash"
//    case squall = "Squall"
//    case tornado = "Tornado"
//}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax, pressure, humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

struct Wind: Codable {
    let speed, deg: Double
}
