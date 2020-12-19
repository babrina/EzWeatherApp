import Foundation

class CurrentWeather: Codable {
    var name: String = ""
    var temp: Double = 0
    var humidity: Int = 0
    var feelsLike: Double = 0
    var pressure: Int = 0
    var wind: Int = 0
    var lon: Double = 0
    var lat: Double = 0
    var picture: String = ""
    
    convenience init() {
        self.init(name: "", temp: 0, humidity: 0, feelsLike: 0, pressure: 0, wind: 0 , lon: 0 , lat: 0, picture: "")
    }
    
    init(name: String, temp: Double, humidity: Int, feelsLike: Double, pressure: Int, wind: Int, lon: Double, lat: Double, picture: String) {
        self.name = name
        self.temp = temp
        self.humidity = humidity
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.wind = wind
        self.lon = lon
        self.lat = lat
        self.picture = picture
        
    }
    
    public enum CodingKeys: String, CodingKey {
        case name, temp, humidity, feelsLike, pressure, wind, lon, lat, picture
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.wind = try container.decode(Int.self, forKey: .wind)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
        
        self.picture = try container.decode(String.self, forKey: .picture)

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.temp, forKey: .temp)
        try container.encode(self.humidity, forKey: .humidity)
        try container.encode(self.feelsLike, forKey: .feelsLike)
        try container.encode(self.pressure, forKey: .pressure)
        try container.encode(self.wind, forKey: .wind)
        try container.encode(self.lat, forKey: .lat)
        try container.encode(self.lon, forKey: .lon)
        try container.encode(self.picture, forKey: .picture)
       
    }
    
}
