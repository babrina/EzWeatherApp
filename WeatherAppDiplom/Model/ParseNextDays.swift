import Foundation

struct ParseNextDays: Codable {
    let cod: String
    let message, cnt: Int
    let list: [ListNextDays]
    let city: CityNextDays
}

struct CityNextDays: Codable {
    let id: Int
    let name: String
    let coord: CoordNextDays
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct CoordNextDays: Codable {
    let lat, lon: Double
}

struct ListNextDays: Codable {
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
}

struct WindNextDays: Codable {
    let speed: Double
    let deg: Double
}

struct CloudsNextDays: Codable {
    let all: Int
}

struct MainClassNextDays: Codable {
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
}

struct RainNextDays: Codable {
    let the3H: Double
}

struct SysNextDays: Codable {
    let pod: String
}

struct WeatherNextDays: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
