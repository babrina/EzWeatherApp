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
}
