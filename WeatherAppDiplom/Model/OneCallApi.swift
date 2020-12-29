import Foundation

// MARK: - OneCallWelcome
struct OneCallWelcome: Codable {
    var lat, lon: Double
    var timezone: String
    var timezoneOffset: Double
    var current: OneCallCurrent
    var hourly: [OneCallCurrent]
    var daily: [OneCallDaily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - OneCallCurrent
struct OneCallCurrent: Codable {
    var dt: Double
    var sunrise, sunset: Double?
    var temp, feelsLike: Double
    var pressure, humidity: Double
    var dewPoDouble, uvi: Double
    var clouds, visibility: Double
    var windSpeed: Double
    var windDeg: Double
    var weather: [OneCallWeather]
    var pop: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoDouble = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, pop
    }
}

// MARK: - OneCallWeather
struct OneCallWeather: Codable {
    var id: Double
    var main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - OneCallDaily
struct OneCallDaily: Codable {
    var dt, sunrise, sunset: Double
    var temp: OneCallTemp
    var feelsLike: OneCallFeelsLike
    var pressure, humidity: Double
    var dewPoDouble, windSpeed: Double
    var windDeg: Double
    var weather: [OneCallWeather]
    var clouds, pop: Double
    var uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoDouble = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, clouds, pop, uvi
    }
}

// MARK: - OneCallFeelsLike
struct OneCallFeelsLike: Codable {
    var day, night, eve, morn: Double
}

// MARK: - OneCallTemp
struct OneCallTemp: Codable {
    var day, min, max, night: Double
    var eve, morn: Double
}
