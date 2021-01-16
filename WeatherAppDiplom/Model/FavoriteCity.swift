import Foundation
import UIKit

class FavoriteCity: Codable {
    
    var lat: String
    var lon: String
    var name: String
    var temp: String
    var icon: String
    var country: String
    
    init(lat: String, lon: String, name: String, temp: String, icon: String, country: String) {
        self.lat = lat
        self.lon = lon
        self.name = name
        self.temp = temp
        self.icon = icon
        self.country = country
    }
    
    convenience init(_ name: String) {
        self.init(lat: "", lon: "", name: name, temp: "", icon: "", country: "")
    }
    
    convenience init() {
        self.init(lat: "", lon: "", name: "", temp: "", icon: "", country: "")
    }
    
    public enum CodingKeys: String, CodingKey {
        case name, lat, lon, icon, temp, country
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lon = try container.decode(String.self, forKey: .lon)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.temp = try container.decode(String.self, forKey: .temp)
        self.country = try container.decode(String.self, forKey: .country)

    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.name, forKey: .name)
        try container.encode(self.lat, forKey: .lat)
        try container.encode(self.lon, forKey: .lon)
        try container.encode(self.icon, forKey: .icon)
        try container.encode(self.temp, forKey: .temp)
        try container.encode(self.country, forKey: .country)

    }
}
